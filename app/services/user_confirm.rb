class UserConfirm

  attr_reader :token

  def initialize(token)
    @token = token
  end

  def execute
    user = User.find_by(confirmation_token: token)
  
    if user.nil?
      return OpenStruct.new(success?: false, user: user, errors: user.errors)
    end

    user.confirmed_at = DateTime.now
    result = user.save

    return OpenStruct.new(success?: result, user: user, errors: user.errors)
  end

end