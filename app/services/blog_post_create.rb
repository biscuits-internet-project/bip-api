class BlogPostCreate
  prepend SimpleCommand

  attr_reader :params, :user

  def initialize(user, params)
    @params = params
    @user = user
  end

  def call
    primary_image = params[:primary_image]
    secondary_image = params[:secondary_image]
    tag_list = params[:tag_list]

    post = BlogPost.new(params.except(:primary_image, :secondary_image, :tag_list))
    post.user = user
    post.tag_list = tag_list
    post.published_at = Time.now if post.state == "published"

    if post.save
      if primary_image.present?
        post.primary_image.attach(primary_image)
      end
      if secondary_image.present?
        post.secondary_image.attach(secondary_image)
      end

      return post
    else
      errors.merge!(post.errors)
    end
  end

end