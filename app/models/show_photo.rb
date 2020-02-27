class ShowPhoto < ApplicationRecord

  belongs_to :show
  belongs_to :user
  has_one_attached :image

end

