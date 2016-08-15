class Song < ActiveRecord::Base
  # validates_uniqueness_of :spotify_id

  belongs_to :playlistsong

end
