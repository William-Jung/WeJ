class PlaylistsongsController < ApplicationController
  def destroy
    @playlistsong = Playlistsong.find(params[:id])
    @playlistsong.destroy
  end
end
