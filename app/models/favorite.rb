class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :show

  validates :show, :user, presence: true

end
