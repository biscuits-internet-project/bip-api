class LikesController < ApplicationController

  # POST /:resource_type/:resource_id/likes
  def create
    like = Like.create(likeable: resource, user: current_user)

    if like.errors.blank?
      render :ok
    else
      render json: { errors: like.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    render :ok
  end

  # DELETE /:resource_type/:resource_id/likes
  def destroy
    likes = Like.where(likeable: resource, user: current_user)
    likes.each(&:destroy)

    render head: :ok
  end
end
