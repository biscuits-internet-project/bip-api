class MetricsGet
  prepend SimpleCommand

  def call
    sql = <<-SQL
      select
        (select count(id) from shows) as total_show_count,
        (select count(distinct(user_id)) from ratings where rateable_type='Show') as show_ratings_distinct_user_count,
        (select count(distinct(user_id)) from ratings where rateable_type='Track') as track_ratings_distinct_user_count,
        (select count(distinct(rateable_id)) from ratings where rateable_type = 'Show') as ratings_distinct_show_count,
        (select count(distinct(rateable_id)) from ratings where rateable_type = 'Track') as ratings_distinct_track_count,
        (select count(*) from ratings where rateable_type = 'Track') as track_ratings_count,
        (select count(*) from ratings where rateable_type = 'Show') as show_ratings_count,
        (select count(*) from users) as user_count,
        (select count(*) from reviews) as review_count,
        (select count(distinct(user_id)) from reviews) as review_users_count,
        (select count(*) from attendances) as sawit_count,
        (select count(*) from favorites) as favorite_Count,
        (select count(*) from blog_posts where state = 'published') as blog_post_count,
        (select count(*) from comments) as blog_post_comment_count;
    SQL

    ActiveRecord::Base.connection.execute(sql)[0]
  end

end