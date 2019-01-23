class SaleItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart #, only: [:create]
  before_action :authenticate
  before_action :find_sale_item, only: [:update, :destroy]


  def create
      @sale_item = @cart.sale_items.new(sale_item_params)
      @sale_item.save

  end

  def update
    @sale_item.update_attributes(sale_item_params)
  end

  def destroy
    @sale_item.destroy
  end

  private
    def sale_item_params
      params.require(:sale_item).permit(:product_id, :quantity)
    end

    def find_sale_item
      @sale_item = @cart.sale_items.find(params[:id])
    end
end
