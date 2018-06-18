class Maintenance::ContactsController < Maintenance::BaseController
	#skip_around_action :scope_current_account
	before_action :authorize
	layout "account"
	def index
		@search = Contact.ransack(params[:q])
		@contacts = @search.result.order("created_at desc").paginate(:page => params[:page])
	end

	def show
		@contact = Contact.find(params[:id])
	end
end
