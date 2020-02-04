class Like
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  validates :likeable, :user, presence: true
end