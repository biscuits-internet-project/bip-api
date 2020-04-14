class CommentsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]
  before_action :set_comment, only: [:update, :destroy]

  def index
    comments = BlogPost.find(params[:blog_post_id]).comments.all

    render json: CommentSerializer.render(comments)
  end

  def create
    post = BlogPost.find(params[:blog_post_id])
    comment = Comment.new(comment_params.merge(commentable: post, user: current_user))

    if comment.save
      render json: CommentSerializer.render(comment), status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def update
    render_not_authorized if @comment.user_id != current_user.id

    if @comment.update(comment_params)
      render json: CommentSerializer.render(@comment)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render_not_authorized if @comment.user_id != current_user.id || !current_user.admin?
    @comment.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:content)
  end
end
