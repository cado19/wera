class AddSaleToSaleItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :sale_items, :sale, foreign_key: true
  end
end
