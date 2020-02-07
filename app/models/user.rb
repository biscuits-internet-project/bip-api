class User < ApplicationRecord
  has_secure_password
  rolify
  validates :email, :username, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  has_one_attached :avatar

  def confirmed?
    confirmed_at.present?
  end

  def admin?
    self.has_role?(:admin)
  end
end
