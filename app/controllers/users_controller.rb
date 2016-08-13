class UsersController < ApplicationController
  def new
  end

  def create
    p params[:user]
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @errors = @user.errors.full_messages
      render new_user_path
    end
  end

  def spotify
    @user = User.first
    # p RSpotify::User.new(request.env['omniauth.auth']).credentials.to_hash
    p request.env['omniauth.auth'].to_hash
    p spotify_user = RSpotify::User.new(request.env['omniauth.auth'].to_hash)
    @user.update(spotify_credentials: spotify_user.to_hash.to_s)

    # p @spotify_user
    # @user.spotify_credentials =
    # redirect_to @user
  end

  def show
    # @user = User.find(params[:id])
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
