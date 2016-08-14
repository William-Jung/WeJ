class VotesController < ApplicationController

  def create
    vote = Vote.create(user_id: params[:user_id], playlistsong: Playlistsong.find(params[:id]), request_type: params[:request_type])
    p "+++++++++++++++++++++++++++"
    p vote
    p "+++++++++++++++++++++++++++"
  end

end
