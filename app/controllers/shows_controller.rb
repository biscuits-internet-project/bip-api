class ShowsController < ApiController
  before_action :set_show, only: [:show, :update, :destroy]
  before_action :authenticate!, only: [:create, :update, :destroy]

  # GET /shows
  def index
    shows = Show.includes(:venue, tracks: [:annotations, :song])
    
    if params[:year].present?
      shows = shows.by_year(params[:year].to_i).order(:date)
    end

    if params[:venue].present?
      venue = Venue.find(params[:venue])
      shows = shows.where(venue_id: venue.id).order(:date)
    end

    if params[:last].present?
      shows = shows.order("date desc").take(params[:last].to_i)
    end

    if params[:city].present? && params[:state].present?
      shows = shows.joins(:venue).merge(Venue.city(params[:city], params[:state]))
    elsif params[:state].present?
      shows = shows.joins(:venue).merge(Venue.state(params[:state]))
    end

    render json: ShowSerializer.render(shows, view: :setlist)
  end

  # GET /shows/1
  def show
    render json: ShowSerializer.render(@show, view: :setlist)
  end

  # POST /shows
  def create
    @show = Show.new(show_params)

    if @show.save
      render json: @show, status: :created, location: @show
    else
      render json: @show.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shows/1
  def update
    if @show.update(show_params)
      render json: @show
    else
      render json: @show.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shows/1
  def destroy
    @show.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show
      @show = Show.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def show_params
      params.fetch(:show, {})
    end
end
