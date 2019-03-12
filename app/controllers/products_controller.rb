class ProductsController < ApplicationController
  include CurrentCart
  before_action :find_product, only: :show
  before_action :set_cart
  before_action :authenticate

  def index
  	@search = Product.ransack(params[:q])
  	@products = @search.result.order("name desc").paginate(:page => params[:page])
  end

  def show

  end

  def available
    @search = Product.available.ransack(params[:q])
    @products = @search.result.order("name desc").paginate(page: params[:page])
    #render 'index'
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
