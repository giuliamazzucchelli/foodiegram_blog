require 'test_helper'
require "selenium-webdriver"
require 'rubygems'


class CommentsTest < ActionDispatch::SystemTestCase
    driven_by :selenium, using: :chrome
    include Devise::Test::IntegrationHelpers

    setup do
        @user = users(:user_one)
        @recipe = recipes(:recipe_two)
    end

    test "should post and edit a comment" do
        sign_in(@user)
        visit recipe_path(@recipe)
        find(:id, "comment_body").set("Amazing!")        
        click_on :commit
        text = find(:xpath, "//*[@id='page-content']/div[1]/div").text
        assert text.include?("Your comment was successfully posted.")
        page.assert_selector('h6',text: 'UserOneFood')
        page.assert_selector('h7',text:'Amazing!')
        click_on "Delete"
        page.accept_alert
        text = find(:xpath, "//*[@id='page-content']/div[1]/div").text
        assert text.include?("Your comment was deleted.") 
    end

end

