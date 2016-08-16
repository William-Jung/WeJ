class PlaylistsongsController < ApplicationController
  def destroy
    @playlistsong = Playlistsong.find(params[:id])
    @playlistsong.destroy
  end

  def songs
    playlist = Playlist.find(params[:playlist_id])
    playlist.update_playlist_rankings
    songs = []
    playlist.playlistsongs.each do |playlistsong|
      song_hash = playlistsong.song.attributes
      song_hash[:has_been_played] = playlistsong.has_been_played
      song_hash[:playlist_id] = playlistsong.playlist_id
      song_hash[:playlistsong_id] = playlistsong.id
      songs << song_hash
    end
    render songs.to_json
  end

  def edit
    Playlistsong.find(params[:playlistsong_id]).update(has_been_played: params[:has_been_played])
    render :nothing => true
  end
end
