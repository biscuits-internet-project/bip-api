class Attendance < ApplicationRecord

  validates :user, :show, presence: true

  belongs_to :show
  belongs_to :user
end
