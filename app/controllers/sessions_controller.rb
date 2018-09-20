class SessionsController < ApplicationController
	skip_before_action :authenticate
	layout 'account'

	def new
	end

	def create
		@user = User.find_by_handle(params[:handle])
		Rails.logger.info("the user: #{@user.handle}")
		if @user && @user.password == params[:password]
			Rails.logger.info("@user.id is #{@user.id}")
			session[:user_id] = @user.id
			Rails.logger.info("Inside the session create action: session[:session_id] is #{session[:session_id]}")
			redirect_to user_path
		else
			flash[:warning] = "Unauthorized. Please enter correct username and password"
			redirect_to new_session_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/'
	end

	private

	def user_params
		params.require(:user).permit(:handle, :cell, :password)
	end

end
