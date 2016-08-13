class Listener < ActiveRecord::Base

  belongs_to :user
  belongs_to :playlist

end
