class Maintenance::AccountsController < Maintenance::BaseController
	layout "account"
	before_action :set_account, only: [:show, :destroy]
	before_action :authorize
	def index
		@search = Account.ransack(params[:q])
		@accounts = @search.result.order("name desc").paginate(:page => params[:page])
	end

	def show
	end

	def destroy
		@account.destroy
		redirect_to maintenance_accounts_url
		flash[:success] = "Account has been destroyed"
	end

	private

	def set_account
		@account = Account.find(params[:id])
	end
end
