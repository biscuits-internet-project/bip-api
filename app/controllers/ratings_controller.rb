class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :update, :destroy]

  # POST /:resource_type/:resource_id/rate
  def create
    rating = Rating.find_by(rateable: resource, user: current_user)

    if rating.present?
      rating.update_attribute(:value, params[:value])
    else
      rating = Rating.new(rateable: resource, user: current_user, value: params[:value])
      if !rating.save
        render json: rating.errors, status: :unprocessable_entity
        return
      end
    end

    render json: { average_rating: resource.average_rating }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rating_params
      params.fetch(:rating, {})
    end
end
