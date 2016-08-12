class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :library_id
      t.string :type

      t.timestamps null: false
    end
  end
end
