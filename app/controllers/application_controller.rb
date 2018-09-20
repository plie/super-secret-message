class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate
  
  attr_reader :current_user

  def authenticate
  	@current_user = User.find_by_id(session[:user_id])
  	unless @current_user
  		flash[:warning] = "Please sign in Jen (application controller)"
  		redirect_to new_session_path
  	end
  end

end
