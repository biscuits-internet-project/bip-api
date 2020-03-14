class UserRegister
  prepend SimpleCommand

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    avatar = params[:avatar]
    params[:password_confirmation] = params[:password]
    user = User.new(params.except(:avatar))

    if user.save
      if avatar.present?
        user.avatar.attach(avatar)
      end
      user.update_attributes(confirmation_token: SecureRandom.uuid, confirmation_sent_at: DateTime.now)
      UserNotifierMailer.send_confirmation(user).deliver
      return user
    else
      errors.merge!(user.errors)
    end
  end

end