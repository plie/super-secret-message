class UsersController < ApplicationController
	skip_before_action :authenticate, only: [:new, :create]
	before_action :set_user, only: [:show, :edit, :update, :destroy]

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
		flash[:success] = "Your account has been destroyed. Thank you for using Super Secret Message!"
		redirect_to '/'
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:cell, :password_hash, :handle)
	end

end
