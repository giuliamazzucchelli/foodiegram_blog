require "selenium-webdriver"
require 'rubygems'
require 'test_helper'


class AdminTest < ActionDispatch::SystemTestCase
    driven_by :selenium, using: :chrome
    include Devise::Test::IntegrationHelpers

    setup do
        @admin = Admin.create(email: "admin11@example.com",password:"password")
    end

    test "should signin as admin" do
        visit new_admin_session_path
        fill_in "Email",with: "admin11@example.com"
        fill_in "Password",with: "password"
        click_on :commit
        text = find(:xpath, "/html/body/div[3]/div/div[2]/div/div[2]").text
        assert text.include?("Signed in successfully.")
    end

    test "admin should create categories" do
        sign_in(@admin)
        visit rails_admin.dashboard_path
        click_on "Categories",match: :first
        click_on "Add new"
        fill_in "Name",with:"Gluten free"
        click_on "Save"
        text = find(:xpath,"/html/body/div[3]/div/div[2]/div/div[2]").text
        assert text.include?("Category successfully created")
        click_on "Home"
        click_on "Categories"
        assert(page.has_text?("Gluten free"))
    end

end
