class SessionsController < ApplicationController
	render layout: 'account'

	def new
	end

	def create
		@user = User.find_by_handle(params[:handle])
		if @user && @user.password == params(:password)
			@session[:session_id] = @user.id
			redirect_to user_path
		else
			flash[:warning] = "Unauthorized. Please enter correct username and password"
			redirect_to new_session_path
		end
	end

	def destroy
		@session[:session_id] = nil
		redirect_to new_session_path
	end

	private

	def user_params
		params.require(:user).permit(:handle, :cell, :password)
	end

end
