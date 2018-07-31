class UsersController < ApplicationController
	before_action :find_user, only: [:show, :edit, :update, :destroy]
	def new
		@user = User.new
		@roles = Role.all
	end

	def show

	end

	private

	def find_user
		@user = User.find(params[:id])
	end
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id, :avatar)
	end
end
