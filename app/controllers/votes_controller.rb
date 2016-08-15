class VotesController < ApplicationController

  def create
    if logged_in?
      playlistsong = Playlistsong.find(params[:id])
      Vote.create(user_id: params[:user_id], playlistsong: playlistsong, request_type: params[:request_type])
      playlist = Playlist.find(playlistsong.playlist_id)
      redirect_to show_playlist_path(playlist)
    else
      redirect_to new_session_path
    end
  end

end
