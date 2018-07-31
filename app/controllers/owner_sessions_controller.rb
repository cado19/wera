class OwnerSessionsController < ApplicationController
  include OwnerSessionsHelper
  def new
  end

  def create
  	owner = Owner.find_by_email(params[:email])
  	if owner && owner.authenticate(params[:password])
  		login_owner owner
  		redirect_to home_index_url
      flash[:notice] = "Welcome to ziada"
  	else
  		flash.now[:alert] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	session[:owner_id] = nil
  	redirect_to login_url
  end
end
