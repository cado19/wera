class AddDefaultToQuantityInProducts < ActiveRecord::Migration[5.1]
  def change
  	change_column :products, :quantity, :integer, default: 0
  end
end
