class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :update, :destroy]
  before_action :ensure_admin!, only: [:create, :update, :destroy]

  # GET /venues
  def index
    venues = Venue.order(:name).all

    render json: VenueSerializer.render(venues)
  end

  # GET /venues/1
  def show
    render json: VenueSerializer.render(@venue)
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
