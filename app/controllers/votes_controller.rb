class VotesController < ApplicationController
  include UsersHelper
  def create
    if logged_in?
      playlistsong = Playlistsong.find(params[:id])
      playlist = Playlist.find(playlistsong.playlist_id)
      # if playlist.votes.where(user_id: current_user.id, request_type: 'vote').count < playlist.request_limit
        Vote.create(user_id: params[:user_id], playlistsong: playlistsong, request_type: params[:request_type])
        playlist.update_playlist_rankings
      # end
      redirect_to show_playlist_path(playlist)
    else
      redirect_to new_session_path
    end
  end
end
