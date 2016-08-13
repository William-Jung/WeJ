class Playlistsong < ActiveRecord::Base

  belongs_to :playlist
  belongs_to :song
  has_many :votes

end
