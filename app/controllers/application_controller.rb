class ApplicationController < ActionController::Base
  include MaintenanceSessionsHelper
  include SessionsHelper
  protect_from_forgery with: :exception

  helper_method :current_account

  around_action :scope_current_account


  def current_account
  	 Account.find_by_subdomain! request.subdomain
  end

  def scope_current_account
  	Account.current_id = current_account.id
  	yield
  ensure
  	Account.current_id = nil
  end

  def authenticate
    redirect_to login_url if current_user.nil?
  end

  def authorize
    redirect_to maintenance_login_url if current_maintenance_user.nil?
  end
end
