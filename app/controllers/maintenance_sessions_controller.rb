class MaintenanceSessionsController < ApplicationController
	include MaintenanceSessionsHelper
	skip_around_action :scope_current_account
	layout "account"
	def new
	end

	def create
		maintenance_user = MaintenanceUser.find_by_email(params[:email])
		if maintenance_user && maintenance_user.authenticate(params[:password])
			login_maintainer maintenance_user
			redirect_to maintenance_root_url
		    flash[:notice] = "Welcome to maintenance site"
		else
			flash.now[:alert] = "Invalid email/password combination"
			render 'new'
		end
	end

	def destroy
		session[:maintenace_user_id] = nil
		redirect_to welcome_url
	end
end
