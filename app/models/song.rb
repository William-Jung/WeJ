class Song < ActiveRecord::Base
  validates_uniqueness_of :

  belongs_to :playlistsong

end
