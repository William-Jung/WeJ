class AddSpotifyIdToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :spotify_id, :string
  end
end
