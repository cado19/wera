class AddAccountToSales < ActiveRecord::Migration[5.1]
  def change
    add_reference :sales, :account, foreign_key: true
  end
end
