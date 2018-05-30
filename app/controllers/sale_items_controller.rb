class SaleItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :authenticate

  def new
    @sale_item = SaleItem.new
  end

  def create
    product = Product.find(params[:product_id])
      @sale_item = @cart.add_product(product)
      if @sale_item.save
        flash[:notice] = "Product Added To Cart"
        redirect_to products_url
      else
        flash[:danger] = "Product Not Added To Cart"
      end
  end
end
