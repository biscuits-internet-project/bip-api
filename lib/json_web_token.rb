class JsonWebToken

  @@secret_key = Rails.application.config.jwt_secret_key

  def self.encode(user, exp = 2.weeks.from_now)
    payload = {
      user_id: user.id,
      email: user.email,
      roles: user.roles.map(&:name),
      first_name: user.first_name,
      last_name: user.last_name,
      username: user.username,
      avatar_url: user.avatar_url,
      exp: exp.to_i
    }

    JWT.encode(payload, @@secret_key)
  end

  def self.decode(token)
    decoded = JWT.decode(token, @@secret_key)[0]
    HashWithIndifferentAccess.new(decoded)
  end

end
