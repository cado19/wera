class SaleItem < ApplicationRecord
  #ASSOCIATIONS
  belongs_to :product
  belongs_to :cart
  belongs_to :account
  belongs_to :sale, optional: true

  #VALIDATIONS
  validate :adequate_product #, on: :create


  #CALLBACKS
  #before_destroy :return_products

  default_scope { where(account_id: Account.current_id) }

  def total_price
    product = self.product
    product.selling_price * self.quantity
  end

  def adequate_product
    product = self.product
    if product.stockable && (self.quantity > product.quantity)
      errors.add(:product, "is out of stock")
    end
  end

  def return_products
    product = self.product
    unless !product.stockable
      product.quantity += self.quantity
      product.save
    end
  end

  def highest_selling
    SaleItem.group(:product_id).sum(:quantity)
  end
end
