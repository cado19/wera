class AddCodeToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :code, :string, index: true
  end
end
