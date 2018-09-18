class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate

  attr_reader :current_user

  private
  
  def authenticate
  	@current_user = User.find_by(id: session[:user_id])
  	unless @current_user
  		flash[:danger] = "Welcome! Please log in."
  		redirect_to new_session_path
  	end
  end

end
