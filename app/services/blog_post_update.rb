class BlogPostUpdate
  prepend SimpleCommand

  attr_reader :params, :blog_post

  def initialize(blog_post, params)
    @params = params
    @blog_post = blog_post
  end

  def call
    primary_image = params[:primary_image]
    secondary_image = params[:secondary_image]
    tag_list = params[:tag_list]

    blog_post.assign_attributes(params.except(:primary_image, :secondary_image, :tag_list))
    blog_post.tag_list = tag_list
    if primary_image.present? && primary_image != blog_post.primary_image
      blog_post.primary_image.attach(primary_image)
    end
    if secondary_image.present? && secondary_image != blog_post.secondary_image
      blog_post.secondary_image.attach(secondary_image)
    end

    post.published_at = Time.now if post.state == "published"

    if blog_post.save
      return blog_post
    else
      errors.merge!(blog_post.errors)
    end
  end

end