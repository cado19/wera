class ProductsController < ApplicationController
  include CurrentCart
  before_action :find_product, only: :show
  before_action :set_cart
  before_action :authenticate
  
  def index
  	@search = Product.ransack(params[:q])
  	@products = @search.result.paginate(:page => params[:page])
  end

  def show

  end

  def destroy
  	@product.destroy
  	flash[:notice] = "Product Successfully Deleted"
  end

  private

  def find_product
  	@product = Product.find(params[:id])
  end

  def product_params
  	params.require(:product).
    permit(:name, :purchase_price, :selling_price, :description, :manufacturer, :category_id)
  end
end
