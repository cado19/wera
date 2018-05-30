class Admin::SalesController < Admin::BaseController
  layout "admin"
  before_action :authenticate
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  def index
    @search = Sale.ransack(params[:q])
    @sales = @search.result.paginate(:page => params[:page])
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SalePdf.new(@sale, @account)
        send_data pdf.render,
                  filename:     "sale_#{@sale.name}",
                  type:         "application/pdf",
                  disposition:  "inline"
      end
    end
  end

  def edit
  end

  def destroy
    @sale.destroy
    redirect_to admin_sales_url
    flash[:notice] = 'Sale Has Been Deleted.'
  end

  #search
  def search
    @search = Sale.ransack(params[:q])
    @sales = @search.result.paginate(:page => params[:page])
    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:name, :pay_type, :pay_amount, :balance)
    end

    def ensure_cart_has_sth
      if @cart.line_items.empty?
        flash[:notice] = "Your Cart is Empty"
        redirect_to store_index_url
      end
    end
end
