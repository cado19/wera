class Admin::UsersController < Admin::BaseController
	layout "admin"
	before_action :find_user, only: [:show, :edit, :update, :destroy]
	before_action :authenticate
	def index
		@search = User.notDeleted.ransack(params[:q])
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
			flash[:notice] = "User successfully Created"
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
		@user.update_attribute(:deleted, true)
    redirect_to admin_users_url
    flash[:success] = "User successfully deleted"
	end

	def deleted
			@search = User.deleted.ransack(params[:q])
			@users = @search.result.order("name desc").paginate(page: params[:page])
	end

	private

		def find_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :role_id)
		end
end
