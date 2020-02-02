class ContactMailer < ApplicationMailer
  default from: ENV['EMAIL_FROM']

  def send_contact(email, name, message)
    @email = email
    @name = name
    @message = message

    mail(to: ENV['CONTACT_EMAIL'], from: email, subject: '[bip] Contact from Website')
  end

end
