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
    if current_owner.nil?
      if current_user.nil?
        redirect_to login_url
      end
    end
    #if current_user.nil? || current_owner.nil?
    #  redirect_to login_url
    #end
    #redirect_to login_user_url if (current_user.nil || current_owner.nil)?
  end

  def authorize
    redirect_to maintenance_login_url if current_maintenance_user.nil?
  end
end
