class Purchase < ApplicationRecord
  #ASSOCIATIONS
  belongs_to :product
  belongs_to :account
  belongs_to :user, optional: true
  belongs_to :owner, optional: true

  #VALIDATIONS
  validates :quantity, presence: true, numericality: {only_integer: true}

  #CALLBACKS
  after_create :update_product_stock
  before_save :save_total
  after_update :remove_product_stock

  default_scope { where(account_id: Account.current_id) }

  def update_product_stock
    product = self.product
    #product_quantity = product.quantity
    new_quantity = product.quantity + self.quantity
    product.update_attributes(quantity: new_quantity)
  end

  def remove_product_stock
    product = self.product
    revertedQuantity = product.quantity - self.quantity
    # product.save
    if (revertedQuantity < 0)
      errors.add(:base, "This product has been sold. Purchase cannot be deleted")
    else
      product.update_attributes(quantity: revertedQuantity)
    end
  end



  def total_price
    self.quantity * self.product.purchase_price
  end

  def save_total
    self[:total_price] = self.total_price
  end

  def self.deleted
    where(deleted: true)
  end

  def self.notDeleted
    where(deleted: false)
  end
end
