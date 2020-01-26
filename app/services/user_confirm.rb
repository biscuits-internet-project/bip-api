class UserConfirm
  prepend SimpleCommand

  attr_reader :token

  def initialize(token)
    @token = token
  end

  def call
    user = User.find_by(confirmation_token: token)
  
    if user.present?
      user.update_attribute(:confirmed_at, DateTime.now)
      return user
    else
      errors.add(:base, "Error finding user by confirmation token")
    end
  end

end