class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :playlistsong_id
      t.string :request_type

      t.timestamps null: false
    end
  end
end
