class Product < ApplicationRecord
  #ASSOCIATIONS
  belongs_to :category
  belongs_to :account
  belongs_to :supplier
  has_many :sale_items
  has_many :sales, through: :sale_items
  has_many :purchases

  #VALIDATIONS
  validates :name, :selling_price, :category_id, presence: true
  validates :name, uniqueness: true

  default_scope { where(account_id: Account.current_id) }


  #CALLBACKS
  before_create :set_code
  
  #scope :stockable, ->  { where (stockable: true) }

  def self.stockable
    where(stockable: true)
  end

  def self.nonstockable
    where(stockable: 'false')
  end

  def generate_code(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  def set_code
    self.code = generate_code(6)
  end

  def set_purchase_price
    self.purchase_price = 0.00
  end

  private

    def ensure_cart_not_referenced_by_any_sale_items
      unless sale_items.empty?
        errors.add(:base, 'Sale Items Present')
        throw :abort
      end
    end
end
