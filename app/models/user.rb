class User < ActiveRecord::Base
  attr_accessor :first_name, :last_name
  has_secure_password
  before_save :full_name

  def full_name
    self.full_name = first_name + ' ' + last_name
  end
end 