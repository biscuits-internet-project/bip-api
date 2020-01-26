class PasswordReset
  prepend SimpleCommand

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    user.update_attributes(reset_password_token: SecureRandom.uuid, reset_password_sent_at: DateTime.now)
    UserNotifierMailer.send_forgot_password(user).deliver
  end

end