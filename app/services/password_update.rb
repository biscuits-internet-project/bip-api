class PasswordUpdate

  attr_reader :token, :password

  def initialize(token, password)
    @token = token
    @password = password
  end

  def execute
    user = User.find_by(reset_password_token: token)

    if user.nil? || user.reset_password_sent_at > 1.hour.ago
      return OpenStruct.new(success?: false, user: nil, errors: "Reset password has expired. Please try again.")
    end

    user.password = password
    user.reset_password_token = SecureRandom.uuid
    user.reset_password_sent_at = DateTime.now
    result = user.save
    
    return OpenStruct.new(success?: result, user: user, errors: user.errors)
  end

end