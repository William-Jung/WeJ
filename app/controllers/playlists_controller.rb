class PlaylistsController < ApplicationController
include UsersHelper
include PlaylistsHelper
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
            song_data = construct_song_data(@song_json)
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
        unless Listener.where(user_id: current_user.id, playlist_id: @playlist.id).count > 0
          Listener.create(user_id: current_user.id, playlist_id: @playlist.id)
        end
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
      if @spotify_song
        song = Song.find_by(spotify_id: @spotify_song.id)
        playlist = Playlist.find(params[:id])
        if song
          playlistsong = playlist.playlistsongs.where(song_id: song.id).first
          if playlist.votes.where(user_id: current_user.id, request_type: 'vote').count < playlist.request_limit
            vote = Vote.new(user_id: current_user.id, playlistsong_id: playlistsong.id, request_type: 'vote')
          end
          unless vote.save
            render status: 429
          end
        else
          song = Song.create(construct_song_data(@spotify_song))
          playlistsong = Playlistsong.create(playlist_id: playlist.id, song_id: song.id)
          if playlist.votes.where(user_id: current_user.id, request_type: 'vote').count < playlist.request_limit
            vote = Vote.create(user_id: current_user.id, playlistsong_id: playlistsong.id, request_type: 'vote')
          end
        end
        render :nothing => true
      else
        render :nothing => true
      end
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
    @playlist = Playlist.find(params[:id])
    if logged_in? && Listener.where(user_id: current_user.id, playlist_id: @playlist.id).count > 0
      @playlist.update_playlist_rankings
      @votes_remaining = @playlist.request_limit - @playlist.votes.where(request_type: 'vote', user_id: current_user.id).count
      if @playlist.top_requested_songs
        @playlistsongs = @playlist.played_songs + @playlist.top_requested_songs
      else
        @playlistsongs = @playlist.played_songs
      end
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
