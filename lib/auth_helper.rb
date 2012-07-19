module AuthHelper
  def basic_auth
    authenticate_or_request_with_http_basic do |email, password|
      user = User.find_by_email(email)
      user && user.authenticate(password) && (session[:user_id] = user)
    end
  end

  def current_user
    user_id = session[:user_id]

    user_id && User
  end
end

