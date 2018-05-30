class AddDefaultPurchasePrice < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :purchase_price, :decimal, default: 0.0
  end
end
