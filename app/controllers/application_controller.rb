class ApplicationController < ActionController::API
  def current_user
    auth_token = request.headers['Authorization']
    return unless auth_token

    User.find_by(token: auth_token)
  end

  def is_admin
    user && user.admin
  end
end
