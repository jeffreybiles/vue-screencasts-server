class Api::TrainingUsersController < ApplicationController
  before_action :authenticate_user

  def index
    users = User.where(bootcamp: true)
    render json: UserSerializer.new(users).serializable_hash
  end

  def create
    user = User.bootcamp_user(params[:username], params[:password])
    render json: UserSerializer.new(user).serializable_hash
  end
end