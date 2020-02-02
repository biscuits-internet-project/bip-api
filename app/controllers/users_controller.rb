class UsersController < ApplicationController
  before_action :authorize_admin
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    users = User.all

    render json: UserSerializer.render(users)
  end

  # GET /users/1
  def show
    render json: UserSerializer.render(@user)
  end

  # POST /users
  def create
    command = UserCreate.call(user_params)
  
    if command.success?
      user = User.find(command.result.id)
      render json: UserSerializer.render(user), status: :created
    else
      render json: command.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: UserSerializer.render(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :username, :avatar)
    end
end
