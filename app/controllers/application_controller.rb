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
    if @current_user.nil? || !@current_user.has_role?(:admin)
      render json: { errors: 'User lacks permission to take that action' }, status: :forbidden
    end
  end

  def resource
    @_resource ||= find_model(params[:resource_type], params[:resource_id])
  end

  def find_model(type, id)
    type.singularize.camelize.constantize.find(id)
  end

end
