class PlaylistsongsController < ApplicationController
  def destroy
    @playlistsong = Playlistsong.find(params[:id])
    @playlistsong.destroy
  end

  def songs
    playlist = Playlist.find(params[:playlist_id])
    playlist.update_playlist_rankings
    songs = []
    playlist.playlistsongs.order(:ranking).each do |playlistsong|
      song_hash = playlistsong.song.attributes
      song_hash[:has_been_played] = playlistsong.has_been_played.to_s
      song_hash[:playlist_id] = playlistsong.playlist_id
      song_hash[:playlistsong_id] = playlistsong.id
      songs << song_hash
    end
    @playlistsong_json = songs.to_json
    render json: songs.to_json
  end

  def edit
    playlistsong = Playlistsong.find(params[:playlistsong_id])
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p params
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    p '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    if params[:has_been_played] == 'true'
      params[:has_been_played] = true
    elsif params[:has_been_played] == 'false'
      params[:has_been_played] = false
    end


    if playlistsong
      playlistsong.update(has_been_played: params[:has_been_played])

    p '--------------------------------------------------------------------------------'
    p 'SUCCESS MOFO'
    p '--------------------------------------------------------------------------------'
    end
    render :nothing => true
  end

end
