class ClearCacheJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.cache.clear
    PgSearch::Multisearch.rebuild(Show)
  end
end
