class CombineItemsInCart < ActiveRecord::Migration[5.1]
  def up
    #replace multiple items for a single product in the cart with one item
    Cart.all.each do |cart|
      #count the number of each product in the cart
      sums = cart.sale_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          #remove individual items
          cart.sale_items.where(product_id: product_id).delete_all

          #replace with a single item
          item = cart.sale_items.build(product_id: product_id)
          quantity = item.quantity
          item.save!
        end
      end
    end
  end
end
