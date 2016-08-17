class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :playlistsong

  validates :user_id, uniqueness: {scope: :playlistsong, message: "You can only request this song once"}
  validates :playlistsong_id, presence: true
end
