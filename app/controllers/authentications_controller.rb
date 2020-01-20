class AuthenticationsController < ApplicationController

  # POST /auth/login
  def login
    user = User.find_by_email(params[:email])

    if user&.user.confirmed?&.user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
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