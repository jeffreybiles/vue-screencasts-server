class Api::UsersController < ApplicationController
  def index
    users = User.all
    render json: UserSerializer.new(users).serializable_hash
  end

  def show
    user = User.find(params["id"])
    render json: UserSerializer.new(user).serializable_hash
  end

  def create
    if(User.find_by email: params["email"]) then
      head 401
    else
      user = User.create(user_create_params)
      user.set_password(params["password"])
      user.set_token()
      render json: UserSerializer.new(user, params: { token: true }).serializable_hash
    end
  end

  private

  def user_create_params
    params.require(:user).permit(:name, :email, :password)
  end
end
