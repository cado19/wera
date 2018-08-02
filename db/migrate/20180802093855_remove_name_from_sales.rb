class RemoveNameFromSales < ActiveRecord::Migration[5.1]
  def change
    remove_column :sales, :name
  end
end
