class Admin::ProductsController < Admin::BaseController
  layout "admin"
  before_action :authenticate
  #before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @search = Product.ransack(params[:q])
    @products = @search.result.order("name desc").paginate(:page => params[:page])
  end

  def show
    @product = Product.find(params[:id])
    #@suppliers = @product.suppliers
  end

  def new
    @product = Product.new
    @categories = Category.all.order('name')
    #@product.details.build
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_url(@product)
      flash[:success] = "Product #{@product.name} successfully created."
    else
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_url(@product)
      flash[:notice] = "Product #{@product.name} successfully updated."
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_url
    flash[:notice] = 'Product was successfully destroyed.'
  end

  #available products
  def available
    @search = Product.available.ransack(params[:q])
    @products = @search.result.order("name desc").paginate(:page => params[:page])
    render 'index'
  end

  #out of stock products
  def unavailable
    @search = Product.unavailable.ransack(params[:q])
    @products = @search.result.order("name desc").paginate(:page => params[:page])
    render 'index'
  end

  #search
  def search
    @search = Product.ransack(params[:q])
    @products = @search.result.paginate(:page => params[:page])
    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product)
      .permit(:name, :purchase_price, :selling_price, :description, :manufacturer, :category_id, :stockable, :supplier_id)
    end
end

#, :image, {supplier_ids: []},
                   # details_attributes: Detail.attribute_names.map(&:to_sym).push(:_destroy)
