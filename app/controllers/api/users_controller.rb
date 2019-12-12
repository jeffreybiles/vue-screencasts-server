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

  def update
    user = current_user
    user.update(user_update_params)
    user.save
    render json: UserSerializer.new(user).serializable_hash
  end

  def get_user_from_token
    user = User.find(params[:id])
    if(user.email_subscription_token == params[:email_subscription_token]) then
      render json: UserSerializer.new(user).serializable_hash
    else
      head 401
    end
  end

  def update_email_subscriptions_from_token
    user = User.find(params[:id])
    if(user.email_subscription_token == params[:email_subscription_token]) then
      user.update(update_via_token_params)
      user.save
      render json: UserSerializer.new(user).serializable_hash
    else
      head 401
    end
  end

  private

  def user_create_params
    params.require(:user).permit(:name, :email, :password, :email_weekly, :email_daily)
  end

  def user_update_params
    params.require(:user).permit(:name, :email, :email_weekly, :email_daily)
  end

  def update_via_token_params
    params.require(:user).permit(:email_weekly, :email_daily)
  end
end
