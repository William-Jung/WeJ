class AddDefaultFalseToHasBeenPlayedOnPlaylistsongsTable < ActiveRecord::Migration
  def change
    change_column_default :playlistsongs, :has_been_played, false
  end
end
