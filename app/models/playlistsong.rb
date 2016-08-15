class Playlistsong < ActiveRecord::Base

  belongs_to :playlist
  belongs_to :song
  has_many :votes

  validates :playlist_id, :song_id, presence: true

end
