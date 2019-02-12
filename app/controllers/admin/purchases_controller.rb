class Admin::PurchasesController < Admin::BaseController
  layout "admin"
  include SessionsHelper
  before_action :authenticate
  before_action :find_purchase, only: [:show, :edit, :update, :destroy]
  def index
    @search = Purchase.notDeleted.ransack(params[:q])
    @purchases = @search.result.order("created_at desc").paginate(:page => params[:page])
  end

  def show
  end

  #GET suppliers/new
  def new
    @purchase = Purchase.new
    @products = Product.notDeleted
    #@suppliers = Supplier.all
  end

  #POST suppliers
  def create
    @purchase = Purchase.new(purchase_params)
    if current_owner
      @purchase.owner_id = current_owner.id
    elsif current_user
      @purchase.user_id = current_user.id
    end
    if @purchase.save
      flash[:notice] = "You Have successfully purchased #{@purchase.quantity} #{@purchase.product.name}s"
      redirect_to admin_purchase_url(@purchase)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @purchase.update_attributes(purchase_params)
      flash[:success] = "You Have successfully Updated The Current Purchase"
      redirect_to admin_purchase_url(@purchase)
    else
      render 'edit'
    end
  end

  def destroy
    #product = Product.find(params[:product_id])
    #@purchase.remove_product_stock
    @purchase.update_attribute(:deleted, true)
    redirect_to admin_purchases_url
    flash[:success] = "Purchase successfully deleted"
  end

  def deleted
    @search = Purchase.deleted.ransack(params[:q])
    @purchases = @search.result.paginate(:page => params[:page])
  end

  private
  def purchase_params
    params.require(:purchase).permit(:supplier_id, :product_id, :total_price, :quantity)
  end

  def find_purchase
    @purchase = Purchase.find(params[:id])
  end
end
