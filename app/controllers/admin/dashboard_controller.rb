class Admin::DashboardController < Admin::BaseController
	layout "admin"
	before_action :authenticate
  def index
		@sales = Sale.all.order("created_at desc").limit(5)
		@purchases = Purchase.all.order("created_at desc").limit(5)
  end
end
