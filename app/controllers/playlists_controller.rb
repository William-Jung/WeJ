class PlaylistsController < ApplicationController

include UsersHelper

  def new
    if logged_in?
      if current_user.spotify_user_hash
        user = current_user
          spotify_user = RSpotify::User.new(user.spotify_user_hash)
          @spotify_playlists = spotify_user.playlists.map{|playlist| [playlist.name, playlist.id]}
      else
        redirect_to playlists_find_path
      end
    else
      redirect_to new_session_path
    end
  end

  def create
    if logged_in?
      if current_user.spotify_user_hash
        @playlist = Playlist.new(playlist_params)
        @playlist.name = params[:name]
        @playlist.admin_id = current_user.id
        @playlist.generate_passcode
        if @playlist.save
          redirect_to playlist_admin_path(@playlist)
        else
          render :new
        end
      else
        redirect_to playlists_find_path
      end
    else
      redirect_to new_session_path
    end
  end

  def find
    unless logged_in?
      redirect_to new_session_path
    end
  end

  def verify
    @playlist = Playlist.find_by(passcode: params[:passcode]) || Playlist.find(params[:id])
    if !@playlist
      @playlist = nil
    end

    if @playlist
      if @playlist.passcode == params[:passcode]
        redirect_to show_playlist_path(@playlist)
      elsif @playlist.admin_id == current_user.id
        redirect_to playlist_admin_path(@playlist)
      else
        render 'find'
      end
    else
      render 'find'
    end
  end

  def update
    if logged_in?
      @spotify_song = RSpotify::Track.find(params[:song])
      render json: @spotify_song
    else
      redirect_to new_session_path
    end
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
    if logged_in?
      @playlist = Playlist.find(params[:id])
      @playlistsongs = @playlist.playlistsongs
    else
      redirect_to new_session_path
    end
  end

  private
    def playlist_params
      params.permit(:spotify_id, :name, :request_limit, :flag_minimum, :allow_explicit)
    end

end
