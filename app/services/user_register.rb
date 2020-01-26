class UserRegister
  prepend SimpleCommand

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    user = User.new(params)
  
    if user.save
      user.update_attributes(confirmation_token: SecureRandom.uuid, confirmation_sent_at: DateTime.now)
      UserNotifierMailer.send_confirmation(user).deliver
      return user
    else
      errors.merge!(user.errors)
    end
  end

end