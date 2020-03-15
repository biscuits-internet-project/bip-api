class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    if user
      JsonWebToken.encode(
        user_id: user.id,
        email: user.email,
        roles: user.roles.map(&:name),
        first_name: user.first_name,
        last_name: user.last_name,
        username: user.username,
        avatar_url: user.avatar_url
      )
    end
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    return user if user && user.confirmed? && user.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end