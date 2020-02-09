class Api::UsersController < ApplicationController
  def create
    if(User.find_by email: params["email"].downcase) then
      head 401
    else
      user = User.create(user_create_params)
      user.set_password(params["password"])
      user.set_token
      user.set_email_token

      newsletters = []
      newsletters.append(3) if user.email_weekly
      newsletters.append(6) if user.email_daily
      
      user.create_sendinblue_contact(newsletters)

      render json: UserSerializer.new(user, params: { token: true }).serializable_hash
    end
  end

  def update
    user = current_user
    if user.check_password(params[:old_password]) then
      user.update(user_update_params)
      user.save

      new_password = params[:new_password]      
      if new_password && new_password.length >= 8 then
        user.set_password(new_password)
      end
      render json: UserSerializer.new(user).serializable_hash
    else
      head 401
    end
    
  end

  def get_user_from_token
    user = User.find(params[:id])
    if(user.email_subscription_token == params[:email_subscription_token]) then
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
    params.require(:user).permit(:name, :email)
  end
end
