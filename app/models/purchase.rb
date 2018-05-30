class Purchase < ApplicationRecord
  #ASSOCIATIONS
  belongs_to :product
  belongs_to :account

  #VALIDATIONS
  validates :quantity, presence: true, numericality: {only_integer: true}

  #CALLBACJS
  after_save :update_product_stock
  before_save :save_total

  default_scope { where(account_id: Account.current_id) }

  def update_product_stock
    product = self.product
    #product_quantity = product.quantity
    new_quantity = product.quantity + self.quantity
    product.update_attributes(quantity: new_quantity)
  end

  def remove_product_stock
    product = self.product
    new_quantity = product.quantity - self.quantity
    product.update_attributes(quantity: new_quantity)
  end

  def total_price
    self.quantity * self.product.purchase_price
  end

  def save_total
    self[:total_price] = self.total_price
  end
end
