class UsersController < ApiController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate!, only: [:update, :destroy, :index, :show]

  # GET /users
  def index
    @users = User.all

    render json: UserSerializer.render(@users)
  end

  # GET /users/1
  def show
    render json: UserSerializer.render(@user)
  end

  # POST /users
  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.render(user), status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {}).permit(:email, :password, :password_confirmation)
    end
end
