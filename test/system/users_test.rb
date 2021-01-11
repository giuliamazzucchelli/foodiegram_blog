require "selenium-webdriver"
require 'rubygems'

require "test_helper"

class UsersTest < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome
  include Devise::Test::IntegrationHelpers

    setup do
      @user = users(:user_one)
      @user2 = users(:user_two)
    end


    test "should signup and edit profile" do
      visit new_user_registration_path
      fill_in "Email", with: "user23@example.com"
      fill_in "Password",with: "password"
      fill_in "Password confirmation",with: "password"
      fill_in "Username", with: "user23"
      click_on :commit
      text = find(:xpath, "//*[@id='page-content']/div[1]/div").text
      assert text.include?("Welcome! You have signed up successfully.")
      click_on "Edit"
      attach_file("Avatar","C:/users/Fabio/Desktop/hummus.jpg")
      fill_in "Bio",with: "Hello foodies"
      click_on :commit
      click_on "user23"
      click_on "Log out"
      text = find(:xpath, "//*[@id='page-content']/div[1]/div").text
      assert text.include?("Signed out successfully")
    end


    test "should follow and then unfollow" do
      sign_in(@user)
      visit user_path(@user2)
      assert_no_selector(:xpath,"//*[@id='unfollow-btn']")
      click_on "Follow"
      assert_no_selector(:xpath,"//*[@id='follow-btn']")
      click_on "Unfollow"

    end

    test "should follow a user and see their recipes on the board" do
      sign_in(@user)
      visit user_path(@user2)
      assert_no_selector(:xpath,"//*[@id='unfollow-btn']")
      click_on "Follow"
      visit board_recipe_url(@user)
      assert "h5","Chocolate Cake"
    end

    test "a user should not follow himself " do
      sign_in(@user)
      visit user_path(@user)
      assert_no_selector(:xpath,"//*[@id='follow-btn']")
    end

end
