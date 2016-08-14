class PlaylistsController < ApplicationController

include UsersHelper

  def find
    unless logged_in?
      redirect_to new_session_path
    end
  end

  def verify
    if params[:id]
      @playlist = Playlist.find(params[:id])
    else
      @playlist = nil
    end

    if @playlist
      if @playlist.passcode == params[:passcode] && @playlist.passcode != nil
        redirect_to playlists_path
      elsif @playlist.admin_id == session[:user_id]
        redirect_to playlist_admin_path
      else
        render 'find'
      end
    else
      render 'find'
    end
  end

  def update
    # @playlist = Playlist.find(params[:id])
    p params
    @spotify_song = RSpotify::Track.find(params[:song])
    render json: @spotify_song
    # @song = Song.new()
  end

  def index
    if logged_in? && current_user.playlists
      @playlists = current_user.playlists.map{|playlist| [playlist.name, playlist.id]}
    elsif logged_in? && current_user.playlists == nil
      @playlists = []
    else
      redirect_to new_session_path
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

end
