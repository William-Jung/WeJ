class VotesController < ApplicationController

  def create
    playlistsong = Playlistsong.find(params[:id])
    Vote.create(user_id: params[:user_id], playlistsong: playlistsong, request_type: params[:request_type])
    playlist = Playlist.find(playlistsong.playlist_id)
    redirect_to show_playlist_path(playlist)
  end

end
