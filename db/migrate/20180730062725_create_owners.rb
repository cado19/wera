class CreateOwners < ActiveRecord::Migration[5.1]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.belongs_to :account, foreign_key: true

      t.timestamps
    end
  end
end
