class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_created(@contact).deliver
      flash[:notice] = "Your message has been sent. Will respond as soon as possible"
      redirect_to welcome_url
    else
      render 'new'
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
