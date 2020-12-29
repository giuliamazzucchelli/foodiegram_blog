require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
        @user = User.create(email: "user@example.com", password: "password", username: "User")
        @user2 = User.create(email: "user2@example.com", password: "password", username: "User2")
    end

    test "should get index" do
        get users_url
        assert_response :success
    end

    test "should  show user" do
        get user_url(@user)
        assert_response :success
    end

    test "should get edit" do
        sign_in(@user)
        get edit_user_url(@user)
        assert_response :success
    end
    
    test "should not edit if not signed in" do
        get edit_user_url(@user)
        assert_redirected_to new_user_session_url
    end

    test "should not edit a different user" do
        sign_in(@user)
        get edit_user_url(@user2)
        assert_redirected_to user_url(@user2)
    end

    test "should update user" do
        sign_in(@user)
        patch user_url(@user.id), params: {user: {username: "User!"}}
        assert_redirected_to user_url(@user)
    end

    test "should not update a different user" do
        sign_in(@user)
        patch user_url(@user2.id), params: {user: {username: "User2!"}}
        assert_redirected_to user_url(@user2)
    end

    

en