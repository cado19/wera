class SalesController < ApplicationController
  before_action :authenticate
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :ensure_cart_has_sth, only: :new
  before_action :set_sale, only: :show

  def new
    @sale = Sale.new
    @sale.customers.build
  end

  def create
  	@sale = Sale.new(sale_params)
    if current_owner
      @sale.owner_id = current_owner.id
    elsif current_user
      @sale.user_id = current_user.id # Get the User performing the sale
    end
    @sale.add_sale_items_from_cart(@cart)
    if @sale.save
    	Cart.destroy(session[:cart_id])
    	session[:cart_id] = nil
    	redirect_to @sale
    	flash[:success] = "Sale has been created"
    else
    	render 'new'
    end
  end

  def show
    @account = current_account
    respond_to do |format|
      format.html
    #  format.pdf do
    #    pdf = SalePdf.new(@sale, @account)
    #    send_data pdf.render,
    #              filename:     "sale_#{@sale.name}",
    #              type:         "application/pdf",
    #              disposition:  "inline"
    #  end
    end
  end

  private

  def set_sale
	  @sale = Sale.find(params[:id])
  end

  def sale_params
 	  params.require(:sale).permit(:name, :pay_type, :pay_amount, :total, :balance,
                          customers_attributes: [:id, :name, :contact])
  end

  def ensure_cart_has_sth
    if @cart.sale_items.empty?
      flash[:notice] = "Your Cart is Empty"
      redirect_to products_url
    end
  end
end
