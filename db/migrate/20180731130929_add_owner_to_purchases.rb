class AddOwnerToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_reference :purchases, :owner, foreign_key: true
  end
end
