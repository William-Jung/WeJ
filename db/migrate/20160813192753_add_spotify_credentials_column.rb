class AddSpotifyCredentialsColumn < ActiveRecord::Migration
  def change
    add_column :users, :spotify_credentials, :text
  end
end
