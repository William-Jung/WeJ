class Playlist < ActiveRecord::Base

  belongs_to :admin, class_name: :User
  has_many :listeners, foreign_key: :user_id
  has_many :playlistsongs
  has_many :songs, through: :playlistsongs
  has_many :votes, through: :playlistsongs

  validates :name, :admin_id, :passcode, presence: true
  validates :passcode, uniqueness: true

  # returns an array of all of the songs in arrays of five
  def group_wej_songs
    self.playlistsongs.each_slice(5).to_a
  end

  def top_requested_songs
    self.playlistsongs.where(has_been_played: false).sort_by {|playlistsong| playlistsong.ranking}.each_slice(5).to_a.first
  end

  def played_songs
    self.playlistsongs.where(has_been_played: true).order(:ranking)
  end

  def currently_playing_song
    self.playlistsongs.where(has_been_played: true).order(:ranking).last.id
  end

  def generate_passcode
    self.passcode = (0...6).map { ('a'..'z').to_a[rand(26)] }.join.upcase
  end

  def update_playlist_rankings
    playlistsongs = self.playlistsongs.order(created_at: 'DESC').sort_by {|playlistsong| playlistsong.votes.where(request_type: 'vote').count}.reverse
    played_songs = 0
    playlistsongs_to_be_played = []
    playlistsongs.each do |playlistsong|
      if playlistsong.has_been_played
        played_songs += 1
      else
        playlistsongs_to_be_played << playlistsong
      end
    end
    playlistsongs_to_be_played.each do |playlistsong|
      playlistsong.update(ranking: playlistsongs_to_be_played.index(playlistsong) + played_songs + 1)
    end
  end
end
