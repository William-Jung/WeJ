class PlaylistsController < ApplicationController

include UsersHelper

  def new
    if logged_in?
      if current_user.spotify_credentials
        @spotify_playlists = RSpotify::User.new(current_user.spotify_user_hash).playlists.map{|playlist| [playlist.name, playlist.id]}
      else
        redirect_to playlists_find_path
      end
    else
      redirect_to new_session_path
    end
  end

  def create
    if logged_in?
      if current_spotify_user
        @playlist = Playlist.new(playlist_params)
        @playlist.name = RSpotify::Playlist.find(current_spotify_user.id, playlist_params[:spotify_id]).name
        @playlist.admin_id = current_user.id
        @playlist.generate_passcode

        if @playlist.save
          tracks = RSpotify::Playlist.find(current_spotify_user.id, playlist_params[:spotify_id]).tracks
          tracks.each do |track|
            @song_json = RSpotify::Track.find(track.id)
            song_data = {
              title: @song_json.name,
              artist: @song_json.artists[0].name,
              album: @song_json.album.name,
              # release_date = @song_json
              album_art: @song_json.album.images[0]['url'],
              spotify_id: track.id
            }
            song = Song.find_by(spotify_id: song_data[:spotify_id])
            unless song
              song = Song.create(song_data)
            end
            Playlistsong.create(playlist: @playlist, song: song, ranking: tracks.index(track) + 1)
          end

          redirect_to playlist_admin_path(@playlist)
        else
          p @playlist.errors.full_messages
          @spotify_playlists = RSpotify::User.new(current_user.spotify_user_hash).playlists.map{|playlist| [playlist.name, playlist.id]}
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
    if params[:passcode]
      @playlist = Playlist.find_by(passcode: params[:passcode])
    else
      Playlist.find(params[:id])
    end

    if @playlist
      if @playlist.passcode == params[:passcode]
        redirect_to show_playlist_path(@playlist)
      elsif @playlist.admin_id == current_user.id
        redirect_to playlist_admin_path(@playlist)
      else
        @errors = true
        render 'find'
      end
    else
      @errors = true
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
      @playlist.update_playlist_rankings
      @votes_remaining = @playlist.request_limit - @playlist.votes.where(request_type: 'vote', user_id: current_user.id).count
      @playlistsongs = @playlist.played_songs + @playlist.top_requested_songs
    else
      redirect_to new_session_path
    end
  end

  def admin
    @playlist = Playlist.find(params[:id])
  end

  private

  def playlist_params
    params.permit(:spotify_id, :name, :request_limit, :flag_minimum, :allow_explicit)
  end
end
