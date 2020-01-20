class ResetPassword

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def execute
    user.reset_password_token = SecureRandom.uuid
    user.reset_password_sent_at = DateTime.now
    user.save!

    UserNotifierMailer.send_forgot_password(user).deliver
  end

end