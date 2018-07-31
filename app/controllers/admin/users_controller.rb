class Admin::UsersController < Admin::BaseController
	layout "admin"
	before_action :find_user, only: [:show, :edit, :update, :destroy]
	before_action :authenticate
	def index
		@search = User.ransack(params[:q])
		@users = @search.result.order("name desc").paginate(page: params[:page])
	end

	def new
		@roles = Role.all
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to admin_users_url
			flash[:notice] = "User Successfully Created"
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
			flash[:success] = "User successfully updated"
		else
			render 'edit'
		end
	end

	def destroy
		@user.destroy
	    redirect_to admin_users_url
	    flash[:success] = "Users Has Been Successfully Removed"
	end

	private

		def find_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
		end
end
