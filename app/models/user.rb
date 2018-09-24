require 'bcrypt'

class User < ApplicationRecord
	include BCrypt
  validates :handle, presence: true
  validates :password, presence: true
  validated :cell, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
