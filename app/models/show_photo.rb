class ShowPhoto < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :show
  belongs_to :user
  has_one_attached :image

  def url
    rails_blob_url(image)
  end

end

