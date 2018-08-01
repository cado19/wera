class Customer < ApplicationRecord
  belongs_to :sale
  belongs_to :account

  default_scope { where(account_id: Account.current_id) }
end
