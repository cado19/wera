class AddAccountToSuppliers < ActiveRecord::Migration[5.1]
  def change
    add_reference :suppliers, :account, foreign_key: true
  end
end
