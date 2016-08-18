class User < ActiveRecord::Base
  attr_accessor :first_name, :last_name
  has_many :playlists, foreign_key: :admin_id
  has_many :votes

  has_secure_password

  validate :validate_full_name
  validates :email, presence: true, uniqueness: true

  def set_full_name
    if !self.full_name
      self.full_name = first_name + ' ' + last_name
    end
  end

  def validate_full_name
    if first_name == "" && last_name == ""
      errors.add(:full_name, "needs first and last name")
    elsif first_name == ""
      errors.add(:full_name, "must include first name")
    elsif last_name == ""
      errors.add(:full_name, "must include last name")
    end
  end

  def spotify_user_hash
    eval(self.spotify_credentials)
  end


end
