class Playlist < ActiveRecord::Base

  belongs_to :user, foreign_key: :admin_id
  has_many :listeners, foreign_key: :user_id
  has_many :playlistsongs

end
