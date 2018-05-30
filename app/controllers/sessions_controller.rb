class SessionsController < ApplicationController
  include SessionsHelper
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		login user
  		redirect_to home_index_url
      flash[:notice] = "Welcome to ziada"
  	else
  		flash.now[:alert] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to login_url
  end
end
