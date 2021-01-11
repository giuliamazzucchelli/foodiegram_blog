require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
    def setup
        @user = users(:user_one)
        @user2 = users(:user_two)
        @recipe = recipes(:recipe_one)
        @recipe2 = recipes(:recipe_two)
        @recipe.picture.attach(io: File.open("C:/users/fabio/Desktop/cookies.jpg"),filename:"food.jpg")

    end


    test "should show recipe" do
        get recipe_url(@recipe)
        assert_response :success
    end

    test "should get new" do
        sign_in(@user)
        get new_recipe_url
        assert_response :success

    end

    test "should create recipe" do
        sign_in(@user)
        assert_difference('Recipe.count',1) do
            post recipes_url, params: {recipe: { title: "Lemon Cookies",
                servings: 4,
                prep_time: 15,
                cook_time: 10,
                ingredients: "1 cup flour 1/2 cup cane sugar 1/2 cup  white sugar 1 egg, 1 pinch of salt 1/4 limon zest ",
                directions: "Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving.",user_id: @user.id}}
        end

        assert_redirected_to recipe_url(Recipe.last)

    end

    test "should not create recipe if not signed in" do
        assert_no_difference('Recipe.count') do
            post recipes_url, params: {recipe: { title: "Lemon Cookies",
                servings: 4,
                prep_time: 15,
                cook_time: 10,
                ingredients: "1 cup flour 1/2 cup cane sugar 1/2 cup  white sugar 1 egg, 1 pinch of salt 1/4 cup lemon zest",
                directions: "Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving.",user_id: 1}}
        end
        assert_redirected_to new_user_session_url
    end

    test "should get board page" do
        sign_in(@user)
        get board_recipe_url(@user)
        assert_response :success
    end

    test "should get edit" do
        sign_in(@user)
        get edit_recipe_url(@recipe)
        assert_response :success

    end

    test "should update recipe" do
        sign_in(@user)
        patch recipe_url(@recipe), params: { recipe: {title: "Chocolate chip cookies" }}
        assert_redirected_to recipe_url(@recipe)
    end

    test "should destroy recipe" do
        sign_in(@user)
        assert_difference('Recipe.count', -1) do
            delete recipe_url(@recipe)
        end
        assert_redirected_to recipes_url

    end

    test "should not destroy recipe if not logged in" do
        assert_difference('Recipe.count', 0) do
            delete recipe_url(@recipe)
        end
        assert_redirected_to new_user_session_url
    end


    test "should not destroy another user recipe" do
        sign_in(@user)
        assert_difference('Recipe.count', 0) do
            delete recipe_url(@recipe2)
        end
        assert_redirected_to recipe_url(@recipe2)

    end

    test "should like a recipe " do 
        sign_in(@user)
        assert_difference("Vote.where('votable_id = ? AND votable_type = ?',@recipe.id,Recipe).count", 1) do
            put like_recipe_url(@recipe), params: {format: 'like', voter_id: @user.id}
        end
        assert_redirected_to recipe_url(@recipe)

   
    end

    test "should dislike a recipe" do
        sign_in(@user)
        @recipe.liked_by @user
        assert_difference("Vote.where('votable_id = ? AND votable_type = ?',@recipe.id,Recipe).count", -1) do
            put like_recipe_url(@recipe), params: {format: 'unlike', voter_id: @user.id}
        end
        assert_redirected_to recipe_url(@recipe)

    end

    test "should delete recipe picture" do
        sign_in(@user)
        assert(@recipe.picture.attached?)
        assert_difference("ActiveStorage::Attachment.count",-1) do
            delete delete_picture_attachment_recipe_url(@recipe)
        end
        assert_redirected_to @recipe
    
    end


    test "should not delete recipe picture if not logged in" do
        assert(@recipe.picture.attached?)
        assert_difference("ActiveStorage::Attachment.count",0) do
            delete delete_picture_attachment_recipe_url(@recipe)
        end
        assert_redirected_to new_user_session_url
    end

    test "should not delete picture of another user recipe" do
        sign_in(@user2)
        assert(@recipe.picture.attached?)
        assert_difference("ActiveStorage::Attachment.count",0) do
            delete delete_picture_attachment_recipe_url(@recipe)
        end
        assert_redirected_to @recipe
    end

    teardown do
        sign_out(@user)
    end


end