module Rateable
  extend ActiveSupport::Concern
  included do
    has_many :ratings, as: :rateable, dependent: :destroy
  end
end
