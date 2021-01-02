class CategoriesController < ApplicationController
 
    def index
      @categories=Category.order(:name).per_page_kaminari(params[:page])
  
    end
  
    def show
      @category=Category.find(params[:id])
      @recipes = @category.recipes.per_page_kaminari(params[:page])
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

 

  end 