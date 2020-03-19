class ReviewsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]
  before_action :set_review, only: [:show, :update, :destroy]

  def index
    reviews = Review.joins(:user).all

    if params[:show_id]
      reviews = reviews.where(show_id: params[:show_id])
    end

    render json: ReviewSerializer.render(reviews)
  end

  # POST /:shows/:show_id/reviews
  def create
    show = Show.find(params[:show_id])
    review = Review.create(show: show, user: current_user, content: params[:content])

    if review.errors.blank?
      render json: ReviewSerializer.render(review), status: 201
    else
      render json: { errors: review.errors }, status: :unprocessable_entity
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
