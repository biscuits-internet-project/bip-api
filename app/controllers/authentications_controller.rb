class AuthenticationsController < ApplicationController
  before_action :ensure_admin!, except: :login

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  # POST /auth/password/reset
  def password_reset
    user = User.find_by_email(params[:email])

    ResetPassword.new(user).execute

    render json: {}, status: :ok
  end

  # PUT /auth/password/update
  def password_update
    result = UpdatePassword.new(token, params[:password]).execute

    if result.success?
      render json: {}, status: :ok
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end