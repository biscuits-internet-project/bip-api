class UserRegister

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def execute

    Rails.logger.info params.inspect

    user = User.new(params)
  
    if user.save
      user.confirmation_token = SecureRandom.uuid
      user.confirmation_sent_at = DateTime.now
      user.save!

      UserNotifierMailer.send_confirmation(user).deliver

      return OpenStruct.new(success?: true, user: user, errors: user.errors)
    else
      return OpenStruct.new(success?: false, user: user, errors: user.errors)
    end
  end

end