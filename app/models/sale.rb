class Sale < ApplicationRecord
  enum pay_type: {
    "Cash" => 0,
    "Mobile Money" => 1
  }

  #ASSOCIATIONS
  belongs_to  :owner, optional: true
  belongs_to  :user, optional: true
  belongs_to  :account
  has_many    :sale_items, dependent: :destroy
  has_many    :products, through: :sale_items
  has_many    :customers, dependent: :destroy

  accepts_nested_attributes_for :customers

  #VALIDATIONS
  # validates :name, presence: true
  validates :pay_type, presence: true, inclusion: {in: pay_types.keys}
  validates :pay_amount, presence: true
  validate  :sufficient_payment

  #CALLBACKS
  before_save     :save_total
  before_save     :gen_balance
  after_save      :update_inventory
  before_create   :set_code
  before_destroy  :return_products

  default_scope { where(account_id: Account.current_id) }

  def generate_code(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  def set_code
    self.code = generate_code(6)
  end

  def self.most_recent(limit)
    order("created_at").limit(limit)
  end

  def add_sale_items_from_cart(cart)
    cart.sale_items.each do |item|
      item.cart_id = nil
      sale_items << item
    end
  end

  def enough_product
    sale_items.each do |sale_item|
      product = sale_item.product
      if sale_item.quantity > product.quantity
        errors.add(:base, "Product Out Of Stock")
      end
    end
  end

  def total_price
    sale_items.to_a.sum {|item| item.total_price}
  end

  def save_total
    self[:total] = self.total_price
  end

  def gen_balance
    self[:balance] = self.pay_amount - self.total_price
  end


  def update_inventory
    sale_items.each do |sale_item|
      product = sale_item.product
      product.quantity -= sale_item.quantity
      product.save
    end
  end

  def return_products
    sale_items.each do |sale_item|
      product = sale_item.product
      unless !product.stockable
        product.quantity += sale_item.quantity
        product.save
      end
    end
  end

  def sufficient_payment
    if self.pay_amount < self.total_price
      errors.add(:base, "Insufficient payment")
    end
  end

  def self.deleted
    where(deleted: true)
  end

  def self.notDeleted
    where(deleted: false)
  end
end
