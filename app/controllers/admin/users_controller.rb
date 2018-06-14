class Admin::UsersController < Admin::BaseController
	layout "admin"
	before_action :find_user, only: [:show, :edit, :update, :destroy]
	before_action :authenticate
	def index
		@search = User.ransack(params[:q])
		@users = @search.result.order("name desc").paginate(page: params[:page])
	end

	def show
		
	end

	def edit
		
	end

	def update
		
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
end