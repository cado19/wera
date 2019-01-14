class CatalogController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @search = Product.available.ransack(params[:q])
    @products = @search.result.order("name desc").paginate(:page => params[:page])
    #@products = Product.available.order("name desc").paginate(:page => params[:page])
    @sale_item = @cart.sale_items.new
  end
end
