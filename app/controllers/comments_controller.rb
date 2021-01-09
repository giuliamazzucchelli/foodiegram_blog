class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit,:update,:destroy]
  before_action :require_same_user, only: [:edit,:update,:destroy]
  
  def new
    @comment = Comment.new
  end
  
  def create
    @commentable = Recipe.find(params[:recipe_id])
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to @commentable, notice: "Your comment was successfully posted."
  end

  def edit
  end

  def update

    if @comment.update(comment_params)
      flash[:notice]="Comment was updated successfully."
    
      if @comment.commentable_type == 'Recipe'
         @recipe = Recipe.find(@comment.commentable_id)
        redirect_to @recipe
      end
    else
      render 'edit'
    end
  end

  def destroy
    if @comment.commentable_type == 'Recipe'
      @recipe = Recipe.find(@comment.commentable_id)
    end
    @comment.destroy
    redirect_back fallback_location: @recipe, notice: "Your comment was deleted."
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
       
    def require_same_user
      if current_user != @comment.user
          flash[:alert] = "You can only edit or delete your own comment"
          if @comment.commentable_type == 'Recipe'
            @recipe = Recipe.find(@comment.commentable_id)
           redirect_to @recipe
         end
      end
    end

      
    def set_commentable
    end
    
end
    