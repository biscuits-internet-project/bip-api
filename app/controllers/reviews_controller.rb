class ReviewsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]
  before_action :set_review, only: [:show, :update, :destroy]

  # POST /:resource_type/:resource_id/reviews
  def index
    reviews = resource.reviews.joins(:user)

    render json: ReviewSerializer.render(reviews)
  end

  # POST /:resource_type/:resource_id/reviews
  def create
    review = Review.create(reviewable: resource, user: current_user, content: params[:content])

    if review.errors.blank?
      render json: ReviewSerializer.render(review), status: 201
    else
      render json: { errors: like.errors }, status: :unprocessable_entity
    end
  end

  # PUT /reviews/:id
  def update
    if @review.user_id == current_user.id || current_user.admin?
      if @review.update_attributes(review_params)
        render json: ReviewSerializer.render(@review), status: 200
      else
        render json: { errors: @review.errors }, status: :unprocessable_entity
      end
    else
      render_not_authorized
    end
  end

  # DELETE /reviews/:id
  def destroy
    if @review.user_id == current_user.id || current_user.admin?
      @review.destroy
      render head: :ok
    else
      render_not_authorized
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.permit(:content)
  end
end
