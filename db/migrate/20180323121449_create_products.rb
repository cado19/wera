class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :code, index: true
      t.string :name, index: true
      t.decimal :selling_price, precision: 12, scale: 3
      t.decimal :purchase_price, precision: 12, scale: 3
      t.integer :quantity, default: 0
      t.string :manufacturer
      t.boolean :deleted, default: false
      t.references :category, foreign_key: true
      t.belongs_to :account, foreign_key: true

      t.timestamps
    end
  end
end
