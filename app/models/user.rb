class User < ActiveRecord::Base
  attr_accessor :first_name, :last_name

  has_secure_password
  before_save :set_full_name

  def set_full_name
    if !self.full_name
      self.full_name = first_name + ' ' + last_name
    end
  end

  def spotify_user_hash
    eval(self.spotify_credentials)
  end
end
