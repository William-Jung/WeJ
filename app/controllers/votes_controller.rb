class VotesController < ApplicationController
  include UsersHelper
  def create
    if logged_in?
      playlistsong = Playlistsong.find(params[:id])
      playlist = Playlist.find(playlistsong.playlist_id)
      if playlist.votes.where(user_id: current_user.id, request_type: 'vote').count < playlist.request_limit
        vote = Vote.new(user_id: params[:user_id], playlistsong: playlistsong, request_type: params[:request_type])

        if vote.save
          playlist.update_playlist_rankings
        else
          @errors = vote.errors.full_messages
        end
      end
      redirect_to show_playlist_path(playlist)
    else
      redirect_to new_session_path
    end
  end
end
