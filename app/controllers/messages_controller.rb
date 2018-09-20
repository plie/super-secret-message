class MessagesController < ApplicationController
  skip_before_action :authenticate
  before_action :get_message, only: [:new, :password]
  
  def new
  end

  def create
    @message = Message.new(message_params)
    if @message.password != '' && @message.save
      flash[:success] = "Your message has been saved. Send the URL to your recipient or unlock below."
      Rails.logger.info("Here is your token: #{@message.token}.")
      redirect_to password_path(@message.token)
    else
      flash.now[:danger] = 'Message not saved. Need to create a valid password.'
      render action: "new"
    end
  end

  def password
  end

  def show
    @message_temp = Message.find_by_token(params[:token])
    if @message_temp && @message_temp.password == params["message"]["password"]
      Rails.logger.info("Authentication succeeded")
      @message = @message_temp
      flash.now[:warning] = 'This message has been deleted. Once you leave this page this message will no longer be available.'
      @message.destroy
    elsif @message_temp == nil
      redirect_to root_path 
    else
      Rails.logger.info("Authentication failed")
      flash[:danger] = "Please use a valid password."
      redirect_to root_path
    end
  end

  private

  def get_message
    @message = Message.new
  end

  def message_params
    params.require(:message).permit(:token, :password, :message_body)
  end

end
