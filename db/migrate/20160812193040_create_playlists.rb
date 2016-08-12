class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.integer :admin_id
      t.string :passcode
      t.integer :request_limit
      t.integer :flag_minimum
      t.boolean :allow_explicit

      t.timestamps null: false
    end
  end
end
