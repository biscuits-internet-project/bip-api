class PasswordUpdate
  prepend SimpleCommand

  attr_reader :token, :password

  def initialize(token, password)
    @token = token
    @password = password
  end

  def call
    user = User.find_by(reset_password_token: token)

    if user.nil? || user.reset_password_sent_at < 2.hour.ago
      errors.add(:base, "Reset password has expired. Please try again.")
      return
    end

    user.password = password
    user.password_confirmation = password
    user.confirmed_at = DateTime.now if user.confirmed_at.blank?

    if user.save
      return user
    else
      errors.merge(user.errors)
    end
  end

end