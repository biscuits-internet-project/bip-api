class UsersController < ApplicationController
  before_action :authorize_admin, except: [:update, :attendances, :favorites, :ratings, :show]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    users = User.all

    render json: UserSerializer.render(users)
  end

  # GET /users/1
  def show
    if current_user.admin? || current_user.id == @user.id
      render json: UserSerializer.render(@user)
    else
      render json: "Not authorized", status: :unprocessable_entity
    end
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
    if current_user.admin? || current_user.id == @user.id
      if @user.update(user_params)
        render json: UserSerializer.render(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render_not_authorized
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # GET /attendances
  def attendances
    show_ids = current_user.attendances.pluck(:show_id)
    render json: show_ids
  end

  def favorites
    show_ids = current_user.favorites.pluck(:show_id)
    render json: show_ids
  end

  def ratings
    ratings = current_user.ratings
    render json: RatingSerializer.render(ratings)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :username, :avatar)
    end
end
