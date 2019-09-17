class Api::UsersController < ActionController::API
  def index
    users = User.all
    render json: UserSerializer.new(users).serializable_hash
  end
end
