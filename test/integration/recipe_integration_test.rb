require 'test_helper'

class RecipeIntegrationTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create( email: "john99@example.com",password: "password",username:"Username6868",remember_created_at: Time.now, created_at: Time.now)
    sign_in(@user)
    @recipe = Recipe.create( title: "Chocolate Cookies",
          servings: 4,
          prep_time: 15,
          cook_time: 10,
          ingredients: "1 cup flour 1/2 cup cane sugar 1/2 cup  white sugar 1 egg, 1 pinch of salt 1/4 cup chocolate chips ",
          directions: "Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving.",
          user_id: @user.id,
          created_at: Time.now,
          updated_at: Time.now )

  end



    test "get new recipe form and create recipe" do
      get '/recipes/new'
      assert_response :success
      assert_difference 'Recipe.count', 1 do
      post recipes_path, params: {recipe: { title: 'Lemon Cookies',
          servings: 4,
          prep_time: 15,
          cook_time: 10,
          ingredients: '1 cup flour 1/2 cup cane sugar 1/2 cup  white sugar 1 egg, 1 pinch of salt 1/4 limon zest ',
          directions: 'Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving.',
          notes: '',
          created_at: Time.now,
          updated_at: Time.now,
          user_id: @user.id}} 
      assert_response :redirect
    end

      follow_redirect!
      assert_response :success
    end

    test "get new recipe form and reject invalid submission" do
      get '/recipes/new'
      assert_response :success
      assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: { title: '',
          servings: 4,
          prep_time: 15,
          cook_time: 10,
          ingredients: '',
          directions: 'Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving.',
          notes: '',
          created_at: Time.now,
          updated_at: Time.now,
          user_id: @user_id}} 
    end

      assert_select 'h4.alert-heading'
    end

    test "should visit index" do
      get recipes_url
      assert_response :success
      assert_select "h1","Recipes"
    end

    test "should show recipe" do
      get recipe_url(@recipe)
      assert_response :success
      assert_select "h2", @recipe.title
    end
=begin
    test "should search" do
      get '/recipes?search=coOKies'
      assert_select "h1","2 recipes found for cookies"
      
    end
=end
    test "should notice if no recipe found" do
      get '/recipes?search=@@!'
      assert_select "h1","No recipes found for @@!"
    end

    test "should not like a recipe more than once" do
      sign_in(@user)
      @recipe.liked_by @user
      assert_difference("Vote.where('votable_id = ? AND votable_type = ?',@recipe.id,Recipe).count", 0) do
          put like_recipe_url(@recipe), params: {format: 'like', voter_id: @user.id}
      end
      assert_redirected_to recipe_url(@recipe)
    end

    test "show a recipe and like it" do
        get recipe_url(@recipe.id)
        assert_response :success
        assert_select 'i.far.fa-heart.fa-2x'
        assert_select 'i.fas.fa-heart.fa-2x',false

        assert_difference("Vote.where('votable_id = ? AND votable_type = ?',@recipe.id,Recipe).count", 1) do
            put like_recipe_url(@recipe), params: {format: 'like', voter_id: @user.id}
        end
        follow_redirect!
        assert_select 'i.fas.fa-heart.fa-2x'
    end

    test "show a recipe and unlike it" do
        get recipe_url(@recipe.id)
        assert_response :success
        assert_select 'i.far.fa-heart.fa-2x'
        assert_select 'i.fas.fa-heart.fa-2x',false
        @recipe.liked_by @user
        assert_difference("Vote.where('votable_id = ? AND votable_type = ?',@recipe.id,Recipe).count", -1) do
            put like_recipe_url(@recipe), params: {format: 'unlike', voter_id: @user.id}
        end
        follow_redirect!
        assert_select 'i.far.fa-heart.fa-2x'
    end

    teardown do
      sign_out(@user)
    end
end