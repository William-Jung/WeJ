class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.string :album
      t.date :release_date
      t.string :album_art

      t.timestamps null: false
    end
  end
end
