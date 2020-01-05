class Annotation < ApplicationRecord
  belongs_to :track

  validates :desc, :track, presence: true
end
