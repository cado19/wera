class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :email, default: ""
      t.string :telephone, default: ""
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
