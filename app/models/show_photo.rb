class ShowPhoto < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :show, counter_cache: true
  belongs_to :user
  has_one_attached :image

  def url
    rails_blob_url(image)
  end

  def thumb_url
    rails_representation_url(image.variant(resize: "200x200").processed)
  end

  def src_set
    [
      "#{url} #{image.metadata["width"]}w",
      "#{thumb_url} 200w"
    ]
  end

  def height
    image.metadata["height"]
  end

  def width
    image.metadata["width"]
  end
end
