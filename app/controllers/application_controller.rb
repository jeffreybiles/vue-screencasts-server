class ApplicationController < ActionController::API
  def current_user
    auth_token = request.headers['Authorization']
    return unless auth_token

    User.find_by(token: auth_token)
  end

  def is_admin
    current_user && current_user.admin
  end

  def authenticate_user
    return head 401 unless is_admin
  end
end
