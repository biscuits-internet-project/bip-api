class JsonWebToken

  @@secret_key = Rails.application.config.jwt_secret_key

  def self.encode(payload, exp = 2.weeks.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, @@secret_key)
  end

  def self.decode(token)
    decoded = JWT.decode(token, @@secret_key)[0]
    HashWithIndifferentAccess.new(decoded)
  end

end
