class SessionsController < ApplicationController
  include SessionsHelper
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
    owner = Owner.find_by_email(params[:email])
    authenticated_user = user && user.authenticate(params[:password])
    authenticated_owner = owner && owner.authenticate(params[:password])
  	if authenticated_user #user && user.authenticate(params[:password])
  		login_user user
      redirect_to home_index_url
      flash[:notice] = "Welcome to ziada"
    elsif authenticated_owner
      login_owner owner
  		redirect_to home_index_url
      flash[:notice] = "Welcome to ziada"
  	else
  		flash.now[:alert] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	session[:user_id] = nil #logout standard user
    session[:owner_id] = nil #logout owner
  	redirect_to login_url
  end
end
