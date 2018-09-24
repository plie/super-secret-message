require 'bcrypt'

class Text < ApplicationRecord
	include Bcrypt
	belongs_to :user
	before_create :generate_token

	validates :alias, presence: true, length: { maximum: 20, too_long: "%{count} charaters is the maximum allowed for the alias" }
	validates :body, presence: true, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed for the message" }
	validates :number, presence: true
	 length: { is: 10, wrong_length: "must be %{count} characters in length" }
	 numericality: { only_integer: true, message: "%{value} is not a phone number. Please enter only the 10 digit number --with no dashes or periods" }
	validates :password, presence: true, length: { maximum: 20, too_long: "%{count} charaters is the maximum allowed for the password" }
	validates :token, presence: true


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