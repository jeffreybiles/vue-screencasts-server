class Api::UsersController < ActionController::API
  def index
    users = User.all
    render json: UserSerializer.new(users).serializable_hash
  end

  def create
    user = User.create(user_create_params)
    render json: UserSerializer.new(user).serializable_hash
  end

  private

  def user_create_params
    params.require(:user).permit(:name, :email, :password)
  end
end
