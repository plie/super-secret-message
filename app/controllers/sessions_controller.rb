class SessionsController < ApplicationController
	before_action :authenticate
	
	def create
		@user = User.find(:user_id)
		if @user && @user.password == params(:password_hash)
			@session[:session_id] = @user.id
		else
			flash[:warning] = "Unauthorized. Please enter correct password"
			redirect_to '/'
		end
	end

	def destroy
		@session[:session_id] = nil
		redirect_to '/'
	end

	private

	def set_user
	end

end
