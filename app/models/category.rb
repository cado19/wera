class Category < ApplicationRecord
  belongs_to :account
  has_many :products

  validates :name, presence: true

  default_scope { where(account_id: Account.current_id) }
end
