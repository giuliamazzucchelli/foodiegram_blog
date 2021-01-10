  
require 'test_helper'


class UsersControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers


    setup do
        @user = User.create(email: "usermail@example.com", password: "password", username: "User98")
        @user2 = User.create(email: "usermail2@example.com", password: "password", username: "User28")
        @user.avatar.attach(io: File.open("C:/users/fabio/Desktop/avatar.jpg"),filename:"avatar.jpg")

    end

    test "should get index" do
        get users_path
        assert_response :success
    end

    test "should  show user" do
        get user_path(@user)
        assert_response :success
    end

    test "should get edit" do
        sign_in(@user)
        get edit_user_path(@user)
        assert_response :success
        sign_out(@user)

    end
    
    test "should not edit if not signed in" do
        get edit_user_path(@user)
        assert_redirected_to new_user_session_path
    end

    test "should not edit a different user" do
        sign_in(@user)
        get edit_user_path(@user2)
        assert_redirected_to user_path(@user2)
        sign_out(@user)

    end

    test "should update user" do
        sign_in(@user)
        patch user_path(@user), params: {user: {username: "User!"}}
        assert_redirected_to user_path(@user)
        sign_out(@user)

    end

    test "should not update a different user" do
        sign_in(@user)
        patch user_path(@user2), params: {user: {username: "User2!"}}
        assert_redirected_to user_path(@user2)
        sign_out(@user)

    end

    test "should delete user" do
        sign_in(@user)
        assert_difference("User.count",-1) do
            delete user_path(@user)
        end
        assert_redirected_to root_path       
        sign_out(@user)

    end

    test "should not delete user if not logged in" do
        assert_difference("User.count",0) do
            delete user_path(@user)
        end
        assert_redirected_to new_user_session_path

    end


    test "should not delete a different user" do
        sign_in(@user)
        assert_difference("User.count",0) do
            delete user_path(@user2)
        end
        assert_redirected_to user_path(@user2)
        sign_out(@user)
    end

    test "should follow a user" do
        sign_in(@user)
        assert_difference("Follow.where('followee_id =?',@user2.id).count",1) do
            post follow_user_path(@user2.id) , params: {follow: {followee_id: @user2.id, follower_id: @user.id}}
        end
        sign_out(@user)
    end


    test "should unfollow a user" do
        sign_in(@user)
        @user.followees << @user2
        assert_difference("Follow.where('followee_id =?',@user2.id).count",-1) do
            post unfollow_user_path(@user2.id) , params: {follow: {followee_id: @user2.id, follower_id: @user.id}}
        end
        sign_out(@user)
    end

    test "should delete user avatar" do
        sign_in(@user)
        assert(@user.avatar.attached?)
        assert_difference("ActiveStorage::Attachment.count",-1) do
            delete delete_avatar_attachment_user_url(@user)
        end
        assert_redirected_to @user
    
    end


    test "should not delete user avatar if not logged in" do
        assert(@user.avatar.attached?)
        assert_difference("ActiveStorage::Attachment.count",0) do
            delete delete_avatar_attachment_user_url(@user)
        end
        assert_redirected_to new_user_session_url
    end

    test "should not delete avatar of another user" do
        sign_in(@user2)
        assert(@user.avatar.attached?)
        assert_difference("ActiveStorage::Attachment.count",0) do
            delete delete_avatar_attachment_user_url(@user)
        end
        assert_redirected_to @user
    end



 


 
end