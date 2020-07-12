class BlogPost < ApplicationRecord
  include Rails.application.routes.url_helpers
  extend FriendlyId
  include Commentable
  acts_as_taggable

  has_one_attached :primary_image, dependent: :destroy
  has_one_attached :secondary_image, dependent: :destroy

  friendly_id :title, use: [:sequentially_slugged, :finders]

  belongs_to :user

  validates :title, :slug, :state, :user, presence: true
  validates :slug, uniqueness: true

  scope :state, -> (state) { where(state: state) }

  def primary_image_url
    rails_blob_url(primary_image) if primary_image.present?
  end

  def secondary_image_url
    rails_blob_url(secondary_image) if secondary_image.present?
  end

end
