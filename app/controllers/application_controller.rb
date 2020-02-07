class ApplicationController < ActionController::API

  before_action :authenticate_request
  attr_reader :current_user

  def not_found
    render json: { error: 'not_found' }
  end

  def authenticate_request
    @current_user = AuthorizeRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def authorize_admin
    if @current_user.nil? || !@current_user.admin?
      render_not_authorized
    end
  end

  def render_not_authorized
      render json: { errors: like.errors }, status: :unprocessable_entity
  end

  def resource
    @_resource ||= find_model(params[:resource_type], params[:resource_id])
  end

  def find_model(type, id)
    type.singularize.camelize.constantize.find(id)
  end

end
