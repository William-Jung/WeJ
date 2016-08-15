class Listener < ActiveRecord::Base

  belongs_to :user
  belongs_to :playlist

  validates :user_id, uniqueness: {scope: :playlist_id}

end
