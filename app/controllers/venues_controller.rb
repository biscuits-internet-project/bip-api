class VenuesController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_venue, only: [:show, :update, :destroy]

  # GET /venues
  def index
    venues = Rails.cache.fetch('venues:all') do
      v = Venue.order(:name).all.to_a
      VenueSerializer.render(v)
    end

    render json: venues
  end

  # GET /venues/1
  def show
    render json: VenueSerializer.render(@venue, view: :details)
  end

  # POST /venues
  def create
    @venue = Venue.new(venue_params)

    if @venue.save
      render json: VenueSerializer.render(@venue), status: :created, location: @venue
    else
      render json: @venue.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /venues/1
  def update
    if @venue.update(venue_params)
      render json: VenueSerializer.render(@venue)
    else
      render json: @venue.errors, status: :unprocessable_entity
    end
  end

  # DELETE /venues/1
  def destroy
    @venue.destroy
  end

  private
    def set_venue
      @venue = Venue.find(params[:id])
    end

    def venue_params
      params.permit(:name, :street, :city, :state, :country, :postal_code, :phone, :website)
    end
end
