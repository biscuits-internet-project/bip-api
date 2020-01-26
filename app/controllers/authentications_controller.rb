class AuthenticationsController < ApplicationController
  skip_before_action :authenticate_request

  # POST /auth/login
  def login
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  # POST /auth/register
  def register
    result = UserRegister.new(user_params).execute
  
    if result.success?
      render json: {}, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def confirm
    result = UserConfirm.new(params[:token]).execute
  
    if result.success?
      render json: {}, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # POST /auth/password/reset
  def password_reset
    user = User.find_by_email(params[:email])

    PasswordReset.new(user).execute

    render json: {}, status: :ok
  end

  # PUT /auth/password/update
  def password_update
    result = PasswordUpdate.new(token, params[:password]).execute

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

  def user_params
    params.except(:format).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end