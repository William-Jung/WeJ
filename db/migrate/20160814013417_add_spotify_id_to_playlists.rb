class AddSpotifyIdToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :spotify_id, :string
  end
end
