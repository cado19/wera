class AddQuantityToSaleItems < ActiveRecord::Migration[5.1]
  def change
    add_column :sale_items, :quantity, :integer
  end
end
