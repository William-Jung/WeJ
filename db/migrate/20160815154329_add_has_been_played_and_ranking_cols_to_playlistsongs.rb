class AddHasBeenPlayedAndRankingColsToPlaylistsongs < ActiveRecord::Migration
  def change
    add_column :playlistsongs, :has_been_played, :boolean
    add_column :playlistsongs, :ranking, :integer
  end
end
