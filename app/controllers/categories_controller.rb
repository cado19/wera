class CategoriesController < ApplicationController
	before_action :find_category, only: :show
	before_action :authenticate
	def index
    @search = Category.ransack(params[:q])
		@categories = @search.result.paginate(:page => params[:page])
	end

	def show
		@products = @category.products
	end

	def destroy
		@category.destroy
		flash[:notice] = "Category Successfully Deleted"
	end

	private

	def find_category
		@category = Category.find(params[:id])
	end

	def category_params
		param.require(:category).permit(:name)
	end
end
