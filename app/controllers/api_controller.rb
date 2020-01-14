class ApiController < ActionController::API
  require "knock"
  include Knock::Authenticable

end