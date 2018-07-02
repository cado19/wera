class AccountsController < ApplicationController
	layout "account"
  	skip_around_action :scope_current_account

	def new
		@account = Account.new
	end

	def create
		@account = Account.new(account_params)
		if @account.save
			redirect_to new_user_url(subdomain: @account.subdomain)
		else
			render 'new'
		end
	end

	def destroy
		@account = Account.find(params[:id])
		@account.destroy
		redirect_to maintenance_accounts_url
	end

	private

	def account_params
		params.require(:account).permit(:name, :subdomain, :email, :country)
	end
end
