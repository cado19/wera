class Account < ApplicationRecord
  cattr_accessor :current_id

  has_many :sales
  has_many :users
  has_many :products

  validates :subdomain, presence: true,
              uniqueness: true,
              format: { with: /\A[a-z][a-z0-9\-]+[a-z0-9]\Z/ }

  validates :name, presence: true

  before_validation :downcase_subdomain

  def downcase_subdomain
    self.subdomain = subdomain.try(:downcase)
  end
end
