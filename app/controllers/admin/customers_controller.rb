class Admin::CustomersController < Admin::BaseController
  layout "admin"
  before_action :authenticate
  def index
    @search = Customer.ransack(params[:q])
    @customers = @search.result.order("created_at desc").paginate(page: params[:page],per_page: 10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.update_attributes(:deleted, true)
    redirect_to admin_customers_url
  end

  def search
    @search = Customer.ransack(params[:q])
    @customers = @search.result.order("created_at desc").paginate(page: params[:page])
  end
end
