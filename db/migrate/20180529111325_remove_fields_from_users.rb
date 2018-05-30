class RemoveFieldsFromUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :telephone
  	remove_column :users, :id_number
  	remove_column :users, :birth_date
  end
end
