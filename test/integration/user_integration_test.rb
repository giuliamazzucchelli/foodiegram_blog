
require 'test_helper'

class UserIntegrationTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
    
    setup do
        @user = User.create(email: "userdemo@example.com", password: "password", username: "UserDemo")
    end

    test "should visit index" do
        get '/users'
        assert_response :success
        assert_select "h1","Food Bloggers"
    end

    test "should visit profile" do
        get user_path(@user)
        assert_response :success
        assert_select "h1", "UserDemo's profile"
        assert_select "h3", "Recipes"

    end

    



end