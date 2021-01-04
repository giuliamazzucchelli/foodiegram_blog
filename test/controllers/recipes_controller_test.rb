require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
    def setup
        @user = User.create(email:"userdemo@example.com",password:"password",username:"UserDemo",bio:"Hello",remember_created_at: Time.now,created_at: Time.now)
        @user2 = User.create(email:"userdemo2@example.com",password:"password",username:"UserDemo2",bio:"Hello",remember_created_at: Time.now,created_at: Time.now)

        @recipe = Recipe.create( title: "Chocolate Cookies",
            servings: 4,
            prep_time: 15,
            cook_time: 10,
            ingredients: "1 cup flour 1/2 cup cane sugar 1/2 cup  white sugar 1 egg, 1 pinch of salt 1/4 cup chocolate chips ",
            directions: "Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving.",
            user_id: @user.id,
            created_at: Time.now,
            updated_at: Time.now )

        @recipe2 = Recipe.create( title: "Chocolate Cookies",
            prep_time: 15,
            ingredients: "1 cup flour 1/2 cup cane sugar 1/2 cup  white sugar 1 egg, 1 pinch of salt 1/4 cup chocolate chips ",
            directions: "Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving.",
            user_id: @user2.id,
            created_at: Time.now,
            updated_at: Time.now )
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

    teardown do
        sign_out(@user)
    end




end