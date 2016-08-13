class Playlist < ActiveRecord::Base

  belongs_to :admin, class_name: :User
  has_many :listeners, foreign_key: :user_id
  has_many :playlistsongs

end
