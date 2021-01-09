require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
    def setup
        @user = User.create(email:"userdemo@example.com",password:"password",username:"UserDemo",bio:"Hello")
        @recipe = Recipe.new( title: "Chocolate Cookies",
            servings: 4,
            prep_time: 15,
            cook_time: 10,
            ingredients: "1 cup flour 1/2 cup cane sugar 1/2 cup  white sugar 1 egg, 1 pinch of salt 1/4 cup chocolate chips ",
            directions: "Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving.",
            user_id: @user.id)
    end


    test "recipe should be valid" do
        assert @recipe.valid?
    end

    test "title should be present" do
        @recipe.title = ""
        assert_not @recipe.valid?
    end

    test "title should not be too short" do
        @recipe.title = "a" * 4
        assert_not @recipe.valid?
    end

    test "title should not be too long" do
        @recipe.title = "a" * 41
        assert_not @recipe.valid?
    end

    test "prep time should be present" do
        @recipe.prep_time = ""
        assert_not @recipe.valid?
    end

    test "serving should not be 0" do
        @recipe.servings = 0
        assert_not @recipe.valid?
    end

    test "directions should be present" do
        @recipe.directions = ""
        assert_not @recipe.valid?
    end

    test "directions should not be too short" do
        @recipe.directions = "a" * 49
        assert_not @recipe.valid?
    end

    test "directions should not be too long" do
        @recipe.directions = "a" * 1001
        assert_not @recipe.valid?
    end

    test "notes should not be too long" do
        @recipe.notes = "a" * 101
        assert_not @recipe.valid?
    end

    test "user should be present" do
        @recipe.user_id = ""
        assert_not @recipe.valid?
    end

    test "picture should be image format" do
        @recipe.picture.attach(io: File.open("C:/users/fabio/Desktop/food.txt"),filename:"food.txt")
        assert_not @recipe.valid?
    end

    test "picture size should be valid" do
        @recipe.picture.attach(io: File.open("C:/users/fabio/Desktop/food_largesize.jpg"),filename:"food.jpg")
        assert_not @recipe.valid?
    end

    test "picture should be valid " do
        @recipe.picture.attach(io: File.open("C:/users/fabio/Desktop/cookies.jpg"),filename:"food.jpg")
        assert @recipe.valid?

    end


end
