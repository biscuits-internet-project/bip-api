class UserNotifierMailer < ApplicationMailer
  default from: ENV['EMAIL_FROM']

  def send_forgot_password(user)
    @user = user
    mail(to: @user.email, subject: '[bip] Reset Password')
  end

end
