class AddDeletedToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :deleted, :boolean, default: false
  end
end
