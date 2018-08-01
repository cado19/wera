class Customer < ApplicationRecord
  belongs_to :sale
  belongs_to :account
end
