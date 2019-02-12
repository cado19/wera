class Customer < ApplicationRecord
  belongs_to :sale
  belongs_to :account

  default_scope { where(account_id: Account.current_id) }

  def self.deleted
    where(deleted: true)
  end

  def self.notDeleted
    where(deleted: false)
  end
end
