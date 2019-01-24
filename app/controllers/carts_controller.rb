class CartsController < ApplicationController
  before_action :authenticate
	before_action :set_cart, only: [:show, :edit, :update, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  def show

  end

  def destroy
  	@cart.destroy if @cart.id = session[:cart_id]
  	session[:cart_id] == nil
  	redirect_to catalog_index_url
  	flash[:notice] = "Your Cart Has Been Successfully Emptied"
  end

  private

  def set_cart
  	@cart = Cart.find(params[:id])
  end

  def invalid_cart
  	logger.error "Attempt to access invalid cart #{params[:cart_id]}"
  	redirect_to store_index_url, alert: "Invalid Cart"
  end
end
