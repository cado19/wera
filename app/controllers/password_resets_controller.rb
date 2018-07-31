class PasswordResetsController < ApplicationController
  before_action :fetch_owner, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new

  end

  def create
  	owner = Owner.find_by_email(params[:email])
  	if owner
  		owner.send_password_reset
  		redirect_to login_url
  		flash[:notice] = "Email has been sent with password reset instructions"
  	else
  		flash.now[:alert] = "You are not the owner of the account"
  	end
  end

  def edit
  	@owner = Owner.find_by_password_reset_token!(params[:id])
  end

  def update
  	if params[:password] == nil?
      @owner.errors.add(:password, "can't be blank")
  	elsif @owner.update_attributes(owner_params)
  		redirect_to login_url
  		flash[:notice] = "Password has been reset"
  	else
  		render 'edit'
  	end
  end

  private

     def owner_params
       params.require(:owner).permit(:password, :password_confirmation)
     end

     def check_expiration
       if @owner.password_reset_sent_at < 2.hours.ago
        redirect_to new_password_reset_url
        flash[:alert] = "Password reset has expired"
       end
     end

     def fetch_owner
       @owner = Owner.find_by_password_reset_token!(params[:id])
     end
end
