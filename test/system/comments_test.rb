require 'test_helper'
require "selenium-webdriver"
require 'rubygems'


class CommentsTest < ActionDispatch::SystemTestCase
    driven_by :selenium, using: :chrome
    include Devise::Test::IntegrationHelpers

    setup do
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
    end

    test "should post and edit a comment" do
        visit new_user_session_path
        fill_in "Email",with: "userdemo2@example.com"
        fill_in "Password",with: "password"
        click_on :commit
        visit recipe_path(@recipe)
        find(:id, "comment_body").set("Amazing!")        
        click_on :commit
        text = find(:xpath, "//*[@id='page-content']/div[1]/div").text
        assert text.include?("Your comment was successfully posted.")
        page.assert_selector('h6',text:'UserDemo2')
        page.assert_selector('h7',text:'Amazing!')
        click_on "Delete"
        page.accept_alert
        text = find(:xpath, "//*[@id='page-content']/div[1]/div").text
        assert text.include?("Your comment was deleted.") 
    end
end

