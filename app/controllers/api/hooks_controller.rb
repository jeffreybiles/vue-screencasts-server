require 'securerandom'

class Api::HooksController < ApplicationController
  def new_training_customer
    email = params[:email]

    if user = User.find_by(email: email)
      user.bootcamp = true
      user.save

      VueTrainingMailer.already_exists(email).deliver!
    else
      password = SecureRandom.alphanumeric(10)
      user = User.bootcamp_user(email, password)
      if user.email == email
        VueTrainingMailer.login_info(email, password).deliver!
      end
    end

    
  end
end