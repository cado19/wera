class OwnersController < ApplicationController
	before_action :find_owner, only: [:show, :edit, :update, :destroy]
	def new
		@owner = Owner.new
	end

	def create
		@owner = Owner.new(owner_params)
		 if @owner.save
			redirect_to login_url
		else
			render 'new'
		end
	end

	def show

	end

	def edit

	end

	def update
		if @owner.update(owner_params)
			redirect_to admin_owner_url(@owner)
			flash[:success] = 'Your details were successfully updated.'
		else
			render 'edit'
		end
	end

	private

	def find_owner
		@owner = Owner.find(params[:id])
	end

	def owner_params
		params.require(:owner).permit(:name, :email, :password, :password_confirmation, :avatar)
	end
end
