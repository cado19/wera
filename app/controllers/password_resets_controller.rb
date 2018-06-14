class PasswordResetsController < ApplicationController
  before_action :fetch_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new
  	
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.role_id = 1
  		user.send_password_reset
  		redirect_to login_url
  		flash[:notice] = "Email has been sent with password reset instructions"
  	else
  		flash.now[:alert] = "You are not the owner of the account"
  	end
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])  	
  end

  def update  
  	if params[:password] == nil?
      @user.errors.add(:password, "can't be blank") 
  	elsif @user.update_attributes(user_params)
  		redirect_to login_url
  		flash[:notice] = "Password has been reset"
  	else
  		render 'edit'
  	end
  end

  private

     def user_params
       params.require(:user).permit(:password, :password_confirmation)
     end

     def check_expiration
       if @user.password_reset_sent_at < 2.hours.ago
        redirect_to new_password_reset_url
        flash[:alert] = "Password reset has expired"
       end
     end

     def fetch_user
       @user = User.find_by_password_reset_token!(params[:id])
     end
end
