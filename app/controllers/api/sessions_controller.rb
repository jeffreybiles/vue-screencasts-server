class Api::SessionsController < ApplicationController
  def create
    user = User.find_by email: params["email"]
    if(user and user.check_password(params["password"])) then
      render json: UserSerializer.new(user, params: { token: true }).serializable_hash
    else
      head 401
    end
  end
end
