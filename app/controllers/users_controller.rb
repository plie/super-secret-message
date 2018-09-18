class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
	end

	def edit
	end

	def update
	end

	def destroy
		@user.destroy
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:cell).permit(:password_hash)
	end

end
