module CurrentCart
  def set_cart
		@cart = Cart.find(session[:cart_id]) #find cart with the current session
	rescue ActiveRecord::RecordNotFound
		@cart = Cart.create
		session[:cart_id] = @cart.id
	end
end
