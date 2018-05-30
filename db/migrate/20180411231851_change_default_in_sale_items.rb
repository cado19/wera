class ChangeDefaultInSaleItems < ActiveRecord::Migration[5.1]
  def change
  	change_column :sale_items, :quantity, :integer, default: 1
  end
end
