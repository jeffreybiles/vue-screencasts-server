class Api::UsersController < ApplicationController
  def create
    if(User.find_by email: params["email"]) then
      head 401
    else
      user = User.create(user_create_params)
      user.set_password(params["password"])
      user.set_token
      user.set_email_token
      render json: UserSerializer.new(user, params: { token: true }).serializable_hash
    end
  end

  private

  def user_create_params
    params.require(:user).permit(:name, :email, :password)
  end
end
