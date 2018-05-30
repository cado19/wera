class HomeController < ApplicationController
	include SessionsHelper
	before_action :authenticate
  def index
  	@user = current_user
  	#@recent_sales = @user.sales.most_recent(5)
  end
end
