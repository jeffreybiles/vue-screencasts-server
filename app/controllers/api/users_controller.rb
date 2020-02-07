require 'sib-api-v3-sdk'

class Api::UsersController < ApplicationController
  def create
    if(User.find_by email: params["email"].downcase) then
      head 401
    else
      user = User.create(user_create_params)
      user.set_password(params["password"])
      user.set_token
      user.set_email_token

      signup_user_for_newsletter(user) if user.email_weekly

      render json: UserSerializer.new(user, params: { token: true }).serializable_hash
    end
  end

  def newsletter_subscribe
    user = current_user
    user.email_weekly = true
    user.save

    signup_user_for_newsletter(user)

    head 200
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
    params.require(:user).permit(:name, :email)
  end

  def update_via_token_params
    params.require(:user).permit(:email_weekly, :email_daily)
  end

  def signup_user_for_newsletter(user)
    api_instance = SibApiV3Sdk::ContactsApi.new
    create_contact = SibApiV3Sdk::CreateContact.new(email: user.email, listIds: [3])

    begin
      #Create a contact
      result = api_instance.create_contact(create_contact)
      p result
    rescue SibApiV3Sdk::ApiError => e
      puts "Exception when calling ContactsApi->create_contact: #{e}"
    end
  end
end
