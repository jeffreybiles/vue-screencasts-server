class Api::TrainingUsersController < ApplicationController
  def index
    users = User.where(bootcamp: true)
    render json: UserSerializer.new(users).serializable_hash
  end

  def create

  end
end