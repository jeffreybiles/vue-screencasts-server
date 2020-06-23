class Api::UsersController < ApplicationController
  before_action :authenticate_user, only: [:index]

  def index
    users = User.all
    render json: user_json(users)
  end

  def create
    if(User.find_by email: params["email"].downcase) then
      head 401
    else
      user = User.build_user(user_create_params, params["password"])

      result = Email.new.create_contact(user)
      user.active_campaign_id = result['contact']['id']
      user.save

      Email.new.update_subscription(user, "1", true) #Master List
      Email.new.update_subscription(user, "2", user.email_weekly)
      Email.new.update_subscription(user, "3", user.email_daily)

      Email.new.add_tag(user, '2') #created-account

      render json: UserSerializer.new(user, params: { token: true }).serializable_hash
    end
  end

  def update
    user = current_user
    old_email = user.email
    if user.check_password(params[:old_password]) then
      user.update(user_update_params)
      user.save

      if(old_email != user.email) then
        Email.new.update_contact(user)
      end

      new_password = params[:new_password]      
      if new_password && new_password.length >= 8 then
        user.set_password(new_password)
      end
      render json: UserSerializer.new(user).serializable_hash
    else
      head 401
    end
  end

  def update_nonsensitive
    user = current_user
    user.next_steps_taken = params[:next_steps_taken] if params[:next_steps_taken]
    user.phone_number = params[:phone_number] if params[:phone_number]

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

  private

  def user_create_params
    params.require(:user).permit(:name, :email, :password, :email_weekly, :email_daily)
  end

  def user_update_params
    params.require(:user).permit(:name, :email)
  end

  def user_json(user)
    UserSerializer.new(user).serializable_hash
  end
end
