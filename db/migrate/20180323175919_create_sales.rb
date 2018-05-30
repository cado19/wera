class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.string :name
      t.integer :pay_type
      t.decimal :pay_amount, precision: 12, scale: 3
      t.decimal :total, precision: 12, scale: 3
      t.decimal :balance, precision: 12, scale: 3

      t.timestamps
    end
  end
end
