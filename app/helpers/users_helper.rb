module UsersHelper

  def logged_in?
    session[:user_id] != nil
  end

  def current_user
    return @session_user ||= User.find(session[:user_id]) if logged_in?
  end

end
