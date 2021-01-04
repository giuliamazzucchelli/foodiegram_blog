require "selenium-webdriver"
require 'rubygems'

require "test_helper"

class RecipesTest < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome
  include Devise::Test::IntegrationHelpers
=begin

  test "should create edit and delete a recipe" do
    visit new_user_session_path
    fill_in "Email",with: "userdem@demo.com"
    fill_in "Password",with: "password"
    click_on :commit
    click_on "New recipe"
    fill_in "Title",with: "Chocolate cookies"
    fill_in "Prep time",with: 15
    fill_in "Cook time", with: 10
    fill_in "Ingredients",with: "1 cup flour 1/2 cup cane sugar 1/2 cup  white sugar 1 egg, 1 pinch of salt 1/4 cup chocolate chips "
    fill_in "Directions", with: "Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving."
    attach_file("Picture","C:/users/Fabio/Desktop/cookies.jpg")
    click_on :commit
    text = find(:xpath, "//*[@id='page-content']/div[1]/div").text
    assert text.include?("Recipe was created successfully")
    page.assert_selector('h2',text:'Chocolate cookies')
    click_on "Edit"
    fill_in "Servings",with: 6
    find(:xpath,"//*[@id='recipe_category_ids']/option[2]").click
    click_on :commit
    text = find(:xpath, "//*[@id='page-content']/div[1]/div").text
    assert text.include?("Recipe was updated successfully")
   
  end

=end
  
end