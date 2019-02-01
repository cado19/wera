class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :subdomain, index: true
      t.string :email
      t.string :country
      t.string :location
      

      t.timestamps

    end
  end
end
