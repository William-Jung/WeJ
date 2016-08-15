module UsersHelper

  def logged_in?
    session[:user_id] != nil
  end

  def current_user
    @session_user ||= User.find(session[:user_id]) if logged_in?
  end

  def current_spotify_user
    @session_spotify_user ||= RSpotify::User.new(current_user.spotify_user_hash)
  end

end
