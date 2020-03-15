class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :show

  validates :show, :user, :value, presence: true
  validates_inclusion_of :value, in: 1..5

  after_save :update_show_average

  private

  def update_show_average
    show.update_attribute(:average_rating, show.ratings.average(:value))
  end
end
