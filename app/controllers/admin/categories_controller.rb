class Admin::CategoriesController < Admin::BaseController
  layout "admin"
  before_action :authenticate
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @search = Category.ransack(params[:q])
    @categories = @search.result.order("created_at desc").paginate(:page => params[:page])
  end

  def show
    @products = @category.products.paginate(:page => params[:page])
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_category_url(@category)
      flash[:notice] = "Category #{@category.name} was successfully created."
    else
      render 'new'
    end
  end

  def update
      if @category.update(category_params)
        redirect_to admin_category_url(@category)
        flash[:notice] = "Category #{@category.name} was successfully updated."
      else
        render 'new'
      end
  end

  def destroy
    @category.update_attributes(:deleted, true)
    redirect_to admin_categories_url
    flash[:notice] = 'Category was successfully deleted.'
  end

  def search
    @search = Category.ransack(params[:q])
    @categories = @search.result.paginate(:page => params[:page])
  end

  def deleted
    @search = Category.deleted.ransack(params[:q])
    @categories = @search.result.paginate(:page => params[:page])
    #render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
