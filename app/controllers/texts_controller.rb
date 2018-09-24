require 'twilio-ruby'

class TextsController < ApplicationController
	skip_before_action :authenticate, only: [:show]
	before_action :set_user
	layout 'account'

	def index
		@texts = Text.all
	end

	def show
		@text_temp = Text.find_by_token(params[:token])
    if @text_temp && @text_temp.password == params["text"]["password"]
      Rails.logger.info("Authentication succeeded")
      @text = @text_temp
      flash.now[:warning] = 'This message has been deleted. Once you leave this page this message will no longer be available.'
      @message.destroy
    elsif @text_temp == nil
      redirect_to root_path 
    else
      Rails.logger.info("Authentication failed")
      flash[:danger] = "Please use a valid password."
      redirect_to root_path
    end
	end

	def new
		@text = Text.new
	end

	def create
		@text = Text.create(user: @user)
    if @text.save
    	flash[:success] = "Message saved and a link was sent to the receiver via text"
    	redirect_to user_path
    else
    	flash[:danger] = "Your message was not created or texted. Please log in and try again (fix this)"
    	redirect_to new_session_path
    end

		boot_twilio
		@text = Text.new
    Rails.logger.info("booting Twilio")
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: @user.cell,
      body: @text.body # this changes to a link with the token to retrieve the message
      )
    Rails.logger.info(params[:Body])
    redirect_to user_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def boot_twilio
  	account_sid = Rails.application.secrets.twilio_sid
  	auth_token = Rails.application.secrets.twilio_token
  	@client = Twilio::REST:Client.new account_sid, auth_token
  end

  def set_text # I think I can delete this
  	@text = Text.find(params[:token])

  def set_user
  	@user = User.find_by(session[:user_id])
  end
end
