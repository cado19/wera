class Account < ApplicationRecord
  cattr_accessor :current_id

  has_many :sale_items, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :suppliers, dependent: :destroy

  validates :subdomain, presence: true,
              uniqueness: true,
              format: { with: /\A[a-z][a-z0-9\-]+[a-z0-9]\Z/ }

  validates :name, presence: true

  before_validation :downcase_subdomain

  def downcase_subdomain
    self.subdomain = subdomain.try(:downcase)
  end
end
