class PlaylistsController < ApplicationController

include UsersHelper

  def find
  end

  def verify
    @playlist = Playlist.find(params[:id])
    if @playlist.passcode == params[:passcode]
      redirect_to playlists_path
    else
      render 'find'
    end
  end

  def index
    if logged_in? && current_user.playlists
      @playlists = current_user.playlists
    elsif logged_in? && current_user.playlists == nil
      @playlists = []
    else
      redirect_to new_user_path
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

end
