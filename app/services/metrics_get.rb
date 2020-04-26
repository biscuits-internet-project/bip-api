class MetricsGet
  prepend SimpleCommand

  def call
    sql = <<-SQL
      select
        (select count(id) from shows) as total_show_count,
        (select count(distinct(user_id)) from ratings) as ratings_distinct_user_count,
        (select count(distinct(show_id)) from ratings) as ratings_distinct_show_count,
        (select count(*) from users) as user_count,
        (select count(*) from ratings) as rating_count,
        (select count(*) from reviews) as review_count,
        (select count(*) from attendances) as sawit_count,
        (select count(*) from favorites) as favorite_Count,
        (select count(*) from blog_posts where state = 'published') as blog_post_count,
        (select count(*) from comments) as blog_post_comment_count;
    SQL

    ActiveRecord::Base.connection.execute(sql)[0]
  end

end