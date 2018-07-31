class Admin::BaseController < ApplicationController
	before_action :verify_user

	def verify_user
		if current_owner.nil?
			redirect_to home_index_url
		elsif current_user && current_user.role_id = 3
			redirect_to home_index_url
		end
	end
end
