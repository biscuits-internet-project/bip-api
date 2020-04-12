class BlogPost < ApplicationRecord
  extend FriendlyId
  include Commentable
  acts_as_taggable

  friendly_id :title, use: [:sequentially_slugged, :finders]

  belongs_to :user

  validates :title, :slug, :state, presence: true
  validates :slug, uniqueness: true

  scope :state, -> (state) { where(state: state) }

end
