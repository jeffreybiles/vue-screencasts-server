class Api::SessionsController < ApplicationController
  def create
    user = User.find_by email: params["email"]
    if(user and user.check_password(params["password"])) then
      render json: {token: user.token}
    else
      head 401
    end
  end

  def destroy
    head 200
  end

  def user
    if current_user
      render json: UserSerializer.new(current_user, params: { admin: current_user.admin }).serializable_hash
    else
      head 401
    end
  end
end
