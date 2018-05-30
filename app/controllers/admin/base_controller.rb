class Admin::BaseController < ApplicationController
	before_action :verify_user

	def verify_user
		if current_user.role_id == 3
			flash[:success] = "Unauthorized"
			redirect_to root_url 
		end
	end
end