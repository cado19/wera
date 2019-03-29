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

  def number_of_available_products
    Product.inStock.notDeleted.count
  end

  def number_of_out_of_stock_products
    Product.unavailable.count
  end


  def number_of_users
    User.count
  end

  #Daily Stats
  def income_today
    Sale.today.sum(:total)
  end

  def expenses_today
    Purchase.today.sum(:total_price)
  end
  # -- End Daily Stats --

  #Weekly Stats
  def income_this_week
    Sale.past_week.sum(:total)
  end

  def expenses_this_week
    Purchase.past_week.sum(:total_price)
  end
  # -- End Weekly Stats --

  #Weekly Stats
  def income_this_month
    Sale.past_month.sum(:total)
  end

  def expenses_this_month
    Purchase.past_month.sum(:total_price)
  end
  # -- End Weekly Stats --



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
