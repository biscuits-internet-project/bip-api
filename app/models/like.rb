class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  after_save :update_likeable_count
  after_destroy :update_likeable_count

  validates :likeable, :user, presence: true

  private

  def update_likeable_count
    likeable.update_attribute(:likes_count, likeable.likes.count)
  end
end
