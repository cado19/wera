class Maintenance::DashboardController < Maintenance::BaseController
	#skip_around_action :scope_current_account
	before_action :authorize
	layout "account"
	def index
		
	end
end