module PlaylistsHelper
  def construct_song_data(song_json)
    song_data = {
      title: song_json.name,
      artist: song_json.artists[0].name,
      album: song_json.album.name,
      # release_date = @song_json
      album_art: song_json.album.images[0]['url'],
      spotify_id: song_json.id
    }
  end
end
