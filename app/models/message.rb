require 'bcrypt'

class Message < ApplicationRecord
  include BCrypt
  before_create :generate_token

  validates :message_body, presence: true
  validates :password, presence: true

  def generate_token
    self.token = SecureRandom.hex(10)
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end