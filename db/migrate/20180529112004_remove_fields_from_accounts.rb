class RemoveFieldsFromAccounts < ActiveRecord::Migration[5.1]
  def change
  	remove_column :accounts, :location
  	remove_column :accounts, :business_type 
  	remove_column :accounts, :email
  end
end
