class AddOwnerToSales < ActiveRecord::Migration[5.1]
  def change
    add_reference :sales, :owner, foreign_key: true
  end
end
