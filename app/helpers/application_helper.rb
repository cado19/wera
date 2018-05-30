module ApplicationHelper
  include SessionsHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def number_of_products
    Product.count
  end

  def number_of_purchases
    Purchase.count
  end

  def number_of_sales
    Sale.count
  end

  def number_of_users
    User.count
  end

  def income_today
    Sale.sum(:total)
  end

  def flash_class(type)
    case type
    when :alert
      "alert-danger"
    when :notice
      "alert-success"
    else
      ""  end
  end
end
