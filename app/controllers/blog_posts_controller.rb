class BlogPostsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :authorize_admin, only: [:create, :update, :destroy, :publish]
  before_action :set_blog_post, only: [:show, :update, :destroy, :publish]

  # GET /blog_posts
  def index
    posts = BlogPost.includes(:primary_image_attachment, :secondary_image_attachment, :user, :taggings)

    begin
      if params[:state]
        posts = posts.state(params[:state])

        if params[:state] == "draft"
          authenticate_request
          if current_user.nil?
            return
          end
          posts = posts.where(user_id: current_user.id)
        end
      else
        posts = posts.state('published')
      end

      if params[:username]
        posts = posts.joins(:user).where(users: { username: params[:username] })
      end
    end

    render json: BlogPostSerializer.render(posts)
  end

  # GET /blog_posts/1
  def show
    render json: BlogPostSerializer.render(@blog_post, view: :full)
  end

  # POST /blog_posts
  def create
    command = BlogPostCreate.call(current_user, blog_post_params)

    if command.success?
      blog_post = BlogPost.find(command.result.id)
      render json: BlogPostSerializer.render(blog_post, view: :full), status: :created
    else
      render json: blog_post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blog_posts/1
  def update
    render_not_authorized if @blog_post.user_id != current_user.id
    @blog_post.tag_list = params[:tag_list]
    if @blog_post.save && @blog_post.update(blog_post_params)
      render json: BlogPostSerializer.render(@blog_post, view: :full)
    else
      render json: @blog_post.errors, status: :unprocessable_entity
    end
  end

  def publish
    render_not_authorized if @blog_post.user_id != current_user.id

    if @blog_post.update_attributes(state: "published", published_at: Time.now)
      render json: BlogPostSerializer.render(@blog_post, view: :full)
    else
      render json: @blog_post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blog_posts/1
  def destroy
    render_not_authorized if @blog_post.user_id != current_user.id

    @blog_post.destroy
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  def blog_post_params
    params.permit(:published_at, :title, :blurb, :content, :primary_image, :secondary_image, :state)
  end

  def index_draft?
    params[:state] == "draft"
  end
end
