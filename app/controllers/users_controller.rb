class UsersController < ApplicationController
  include UsersHelper

  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to playlists_find_path
    else
      @errors = @user.errors.full_messages
      render new_user_path
    end
  end

  def spotify
    if logged_in?
      @user = current_user
      p @user
      spotify_user = RSpotify::User.new(request.env['omniauth.auth'].to_hash)
      p @spotify_user
      @user.update(spotify_credentials: spotify_user.to_hash.to_s)
      p @user.errors
      redirect_to playlists_path
    else
      redirect_to new_session_path
    end
  end

  def show
    @user = User.find(params[:id])

    unless @user && @user.id == current_user.id
      redirect_to new_session_path
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
