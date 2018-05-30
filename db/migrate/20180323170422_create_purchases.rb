class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.references :product, foreign_key: true
      t.integer :quantity
      t.decimal :total_price, precision: 12, scale: 3
      t.belongs_to :account, foreign_key: true

      t.timestamps
    end
  end
end
