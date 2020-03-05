class ShowsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_show, only: [:update, :destroy, :attend, :unattend]

  # GET /shows
  def index
    if params[:search].present?
      ids = PgSearch.multisearch(params[:search]).pluck(:searchable_id).take(100)
      shows = Show.includes(:venue, :show_youtubes, tracks: [:annotations, :song]).merge(Track.setlist).where(id: ids).to_a
      shows = shows.sort {|a,b| a.date <=> b.date }
    elsif params[:last].present?
      ids = Show.order("date desc").limit(params[:last].to_i)
      shows = Show.includes(:venue, :show_youtubes, tracks: [:annotations, :song]).merge(Track.setlist).where(id: ids).to_a
      shows = shows.sort {|a,b| b.date <=> a.date }
    else
      shows = base_shows

      if params[:year].present?
        shows = shows.by_year(params[:year].to_i)
      end

      if params[:venue].present?
        venue = Venue.find(params[:venue])
        shows = shows.where(venue_id: venue.id)
      end

      if params[:city].present? && params[:state].present?
        shows = shows.joins(:venue).merge(Venue.city(params[:city], params[:state]))
      elsif params[:state].present?
        shows = shows.joins(:venue).merge(Venue.state(params[:state]))
      end

      shows = shows.sort {|a,b| a.date <=> b.date }
    end

    render json: ShowSerializer.render(shows, view: :setlist)
  end

  # GET /shows/1
  def show
    show = Show.includes(:venue, tracks: [:annotations, :song]).merge(Track.setlist).find(params[:id])
    render json: ShowSerializer.render(show, view: :setlist)
  end

  # POST /shows
  def create
    command = ShowCreate.call(show_params, params[:tracks])

    if command.success?
      show = Show.find(command.result.id)
      render json: ShowSerializer.render(show, view: :setlist), status: :created
    else
      render json: { errors: command.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shows/1
  def update
    if @show.update(show_params)
      render json: ShowSerializer.render(@show, view: :normal)
    else
      render json: @show.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shows/1
  def destroy
    @show.destroy
  end

  # POST /shows/1/attend
  def attend
    attendance = Attendance.new(show: @show, user: current_user)

    if attendance.save
      render head: :ok
    else
      render json: attendance.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    render :ok
  end

  # POST /shows/1/unattend
  def unattend
    attendances = Attendance.where(show: @show, user: current_user)
    attendances.each(&:destroy)
    render head: :ok
  end


  private

    def base_shows
      Show.includes(:venue, :show_youtubes, tracks: [:annotations, :song]).merge(Track.setlist)
    end

    def set_show
      @show = Show.find(params[:id])
    end

    def show_params
      params.permit(:date, :venue_id, :notes)
    end
end
