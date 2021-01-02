class UsersController < ApplicationController 
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        @recipes = @user.recipes.per_page_kaminari(params[:page])
    end

    def index
        @users=User.order(:username).per_page_kaminari(params[:page])    
    end
    
    def edit
    end


    def update
        if @user.update(user_params)
            flash[:notice]="Your account information was successfully updated"
            redirect_to @user
        else
            render 'edit'
        end

    end

    def destroy
        @user.destroy
        flash[:notice] = "Your account was successfully deleted"
        redirect_to root_path

    end


    #follow e unfollow


    private
    #whitelist
    def user_params
        params.require(:user).permit(:username, :email, :password,:avatar,:username,:bio)
    end

    def set_user
        @user=User.find(params[:id])
    end
    def require_same_user
        if current_user != @user 
          flash[:alert] = "You can only edit or delete your own account"
          redirect_to @user
        end
    end
end