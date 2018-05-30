class AddCountryToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :country, :string
  end
end
