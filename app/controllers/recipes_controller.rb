class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy,:like,:delete_picture_attachment]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy,:delete_picture_attachment]
  respond_to :js, :html, :json

  def show

  end
  
  def index
    @recipes=Recipe.order(:created_at).per_page_kaminari(params[:page])
    if params[:search]
        @search_term=params[:search]
        @recipes=@recipes.search_by(@search_term)
    end
  end

  def board
    @recipes= Recipe.of_followed_users(current_user.followees).order('created_at DESC').per_page_kaminari(params[:page])
  end

  
  def new 
    @recipe=Recipe.new
  end
  
  def edit
  end
  
  def create
    @recipe=Recipe.new(recipe_params)
    @recipe.user=current_user
    if @recipe.save
        flash[:notice]="Recipe was created successfully."
        redirect_to @recipe
    else
        render 'new'
    end
  end 
  
  def update
    if @recipe.update(recipe_params)
        flash[:notice]="Recipe was updated successfully."
        redirect_to @recipe
    else
        render 'edit'
    end
  end
  
  def destroy
    if @recipe.destroy
      flash[:notice]="Recipe was deleted successfully."
    else
      flash[:alert] = "An error prevent your recipe from being deleted."
    end
    redirect_to recipes_path
    
  end

  def like
    if params[:format] == 'like'
      @recipe.liked_by current_user
    elsif params[:format] == 'unlike'
      @recipe.unliked_by current_user 
    end
    redirect_back fallback_location: recipe_url
  end 

  def delete_picture_attachment
    if @recipe.picture.purge
      flash[:notice]="Picture was deleted successfully."
    else
      flash[:alert] = "An error prevent the image from being deleted."
    end
    redirect_to @recipe
  end

  private 
  
    def set_recipe
        @recipe = Recipe.find(params[:id])
    end
        
     def recipe_params
        params.require(:recipe).permit(:title,:prep_time,:cook_time,:servings,:directions,:ingredients,:notes,:picture,category_ids: [])
    end

    def require_same_user
      if current_user != @recipe.user
        flash[:alert] = "You can only edit or delete your own recipe"
        redirect_to @recipe
      end
    end

end