class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :contact
      t.belongs_to :sale, foreign_key: true
      t.belongs_to :account, foreign_key: true
      t.boolean :deleted, default: false


      t.timestamps
    end
  end
end
