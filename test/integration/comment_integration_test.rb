require 'test_helper'

class CommentIntegrationTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
        @user = User.create(email:"userdemo@example.com",password:"password",username:"UserDemo",bio:"Hello")
        @user2 = User.create(email:"userdemo2@example.com",password:"password",username:"UserDemo2")

        @recipe = Recipe.create( title: "Chocolate Cookies",
            servings: 4,
            prep_time: 15,
            cook_time: 10,
            ingredients: "1 cup flour 1/2 cup cane sugar 1/2 cup  white sugar 1 egg, 1 pinch of salt 1/4 cup chocolate chips ",
            directions: "Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving.",
            user_id: @user.id)
        @comment = Comment.create(body:"Good!",commentable_id: @recipe.id, user_id: @user.id,commentable_type:"Recipe")
        @commentable_id = @recipe.id
        @commentable_type = 'Recipe'
    end

    test "should show a recipe and its comments" do
        get recipe_url(@recipe)
        assert_response :success
        assert_select 'h5.card-title','1 comment'
    end

end

