class Track < ApplicationRecord
  belongs_to :song
  belongs_to :show
  has_many :annotations, dependent: :destroy
  has_one :venue, through: :show

  validates :song, :show, :position, :set, presence: true

  delegate :title, to: :song, prefix: true
  delegate :slug, to: :song, prefix: true
end
