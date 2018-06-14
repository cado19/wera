module MaintenanceSessionsHelper
	def login_maintainer(maintenance_user)
		session[:maintenance_user_id] = maintenance_user.id
	end

	#Return Current logged in maintenance user if any
	def current_maintenance_user
		@current_user ||= MaintenanceUser.find_by(id: session[:maintenance_user_id])
	end

	def maintenance_logged_in?
		current_maintenance_user.nil?
	end
end
