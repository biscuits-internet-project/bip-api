class ApplicationController < ActionController::API

  def not_found
    render json: { error: 'not_found' }
  end

  def authenticate!
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def ensure_admin!
    authenticate!
    return if @current_user.has_role?(:admin)
    render json: { errors: 'User lacks permission to take that action' }, status: :forbidden
  end

end
