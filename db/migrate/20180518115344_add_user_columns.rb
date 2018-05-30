class AddUserColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :telephone, :string
    add_column :users, :birth_date, :date
    add_column :users, :id_number, :string
  end
end
