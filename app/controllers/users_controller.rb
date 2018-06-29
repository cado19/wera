class UsersController < ApplicationController
	before_action :find_user, only: [:show, :edit, :update, :destroy]
	def new
		@user = User.new
		@roles = Role.all
	end

	def create
		@user = User.new(user_params)
		 if @user.save
			if session[:user_id]
				redirect_to root_url
				flash[:success] = "User has been created"
			else
				redirect_to login_url
			end			
		else
			render 'new'
		end
	end

	def show

	end

	def edit

	end

	def update
		if @user.update(user_params)
			redirect_to admin_user_url(@user)
			flash[:success] = 'User was successfully updated.'
		else
			render 'edit'
		end
	end

	private

	def find_user
		@user = User.find(params[:id])
	end
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id, :avatar)
	end
end
