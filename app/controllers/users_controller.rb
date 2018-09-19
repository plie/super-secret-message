class UsersController < ApplicationController
	before_action :set_and_authenticate_user, only: [:show, :edit, :update, :destroy]
	layout 'account'

	attr_reader :current_user

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.password_hash = user_params[:password_hash]
		if @user.save
			flash[:success] = "New account created. Welcome!"
			redirect_to user_path
		else
			flash[:danger] = "New account not created. Please try again"
			redirect_to new_user_path
		end
	end

	def edit
	end

	def update
		@user.assign_attributes(user_params)
		if @user.save
			flash[:success] = "Your changes were saved."
			redirect_to user_path
		else
			flash[:danger] = "Your new information was not saved. Please try again."
			redirect_to edit_user_path
		end
	end

	def destroy
		@user.destroy
		flash[:success] = "Your account, your data and all unopened messages have been deleted. Thank you for using Super Secret Message!"
		redirect_to '/'
	end

	private

	def set_and_authenticate_user
		@current_user = User.find_by(id: session[:user_id])
		unless @current_user
			flash[:success] = "Welcome! Please log in."
			redirect_to new_session_path
		end
		@user = @current_user
	end

	def user_params
		params.require(:user).permit(:cell, :password_hash, :handle)
	end

end
