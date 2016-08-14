class PlaylistsController < ApplicationController

include UsersHelper

  def new
    p current_spotify_user
    @spotify_playlists = current_spotify_user.playlists.map{|playlist| [playlist.name, playlist.id]}
  end

  def create
    @playlist = Playlist.new(playlist_params)

    @playlist.name = playlist_params[:name]
    @playlist.admin_id = current_user.id
    @playlist.generate_passcode

    if @playlist.save
      RSpotify::Playlist.find(current_spotify_user.id, playlist_params[:spotify_id]).tracks.each do |track|

        @song_json = RSpotify::Track.find(track.id)
        song_data = {
          title: @song_json.name,
          artist: @song_json.artists[0].name,
          album: @song_json.album.name,
          # release_date = @song_json
          album_art: @song_json.album.images[0]['url'],
          spotify_id: track.id
        }

        song = Song.create(song_data)
        Playlistsong.create(playlist: @playlist, song: song)

        @playlist.save
      end

      redirect_to playlist_admin_path(@playlist)
    else
      render :new
    end

  end

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

  def admin
    @playlist = Playlist.find(params[:id])



  end

  private
  def playlist_params
    params.permit(:spotify_id, :name, :request_limit, :flag_minimum, :allow_explicit)
  end

end
