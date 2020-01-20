class UserNotifierMailer < ApplicationMailer
  default from: ENV['EMAIL_FROM']

  def send_forgot_password(user)
    @user = user
    mail(to: @user.email, subject: '[bip] Reset Password')
  end

  def send_confirmation(user)
    @user = user
    mail(to: @user.email, subject: '[bip] Confirm Email')
  end

end
