class Rating < ApplicationRecord
  belongs_to :rateable, polymorphic: true
  belongs_to :user

  validates :rateable, :user, :value, presence: true
  validates_inclusion_of :value, in: 1..5

  after_save :update_average

  private

  def update_average
    rateable.update_attribute(:average_rating, rateable.ratings.average(:value))
  end
end
