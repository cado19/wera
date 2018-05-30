class Cart < ApplicationRecord
  belongs_to :account
  has_many :sale_items, dependent: :destroy

  default_scope { where(account_id: Account.current_id) }

  def add_product(product)
    current_item = sale_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = sale_items.build(product_id: product.id)
    end
    current_item
  end

  def total_price
    sale_items.to_a.sum {|item| item.total_price}
  end

end
