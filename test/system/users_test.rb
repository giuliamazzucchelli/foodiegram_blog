require "selenium-webdriver"
require 'rubygems'

require "test_helper"

class UsersTest < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome
  include Devise::Test::IntegrationHelpers



  test "should signup and edit profile" do
        visit new_user_registration_path
        fill_in "Email", with: "user22@example.com"
        fill_in "Password",with: "password"
        fill_in "Password confirmation",with: "password"
        fill_in "Username", with: "user22"
        click_on :commit
        text = find(:xpath, "").text
        assert text.include?("Welcome! You have signed up successfully.")
        click_on "Edit"
        attach_file("Avatar","C:/users/Fabio/Desktop/hummus.jpg")
        fill_in "Bio",with: "Hello foodies"
        click_on :commit
        click_on "user22"
        click_on "Log out"
        text = find(:xpath, "").text
        assert text.include?("Signed out successfully")

    end


   

end
