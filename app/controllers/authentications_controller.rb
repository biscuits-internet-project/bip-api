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
    command = UserRegister.call(user_params)
  
    if command.success?
      render json: {}, status: :created
    else
      render json: command.errors, status: :unprocessable_entity
    end
  end

  def confirm
    command = UserConfirm.call(params[:token])
  
    if command.success?
      render json: {}, status: :created
    else
      render json: command.errors, status: :unprocessable_entity
    end
  end

  # POST /auth/password/reset
  def password_reset
    user = User.find_by_email(params[:email])

    if user.nil?
      render json: { error: "User not found" }, status: 404
    else
      command = PasswordReset.call(user)

      if command.success?
        render json: {}, status: :created
      else
        render json: command.errors, status: :unprocessable_entity
      end
    end
  end

  # PUT /auth/password/update
  def password_update
    command = PasswordUpdate.call(params[:token], params[:password])

    if command.success?
      render json: {}, status: :ok
    else
      render json: command.errors, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def user_params
    params.except(:format).permit(:first_name, :last_name, :email, :password, :password_confirmation, :username)
  end
end