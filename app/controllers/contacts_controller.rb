class ContactsController < ApplicationController
  layout "account"
  skip_around_action :scope_current_account
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:notice] = "Your message has been sent. Will respond as soon as possible"
      redirect_to welcome_home_url
    else
      render 'new'
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
