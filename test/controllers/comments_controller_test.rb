require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
        @user = users(:user_one)
        @user2 = users(:user_two)
        @recipe = recipes(:recipe_one)
        @comment = comments(:one)
        @commentable_id = @recipe.id
        @commentable_type = 'Recipe'
    end

    test "should post a comment" do
        sign_in(@user)
        assert_difference('Comment.count',1) do
            post recipe_comments_url(@recipe), params: {comment: { body: @comment.body, commentable_id: @recipe.id, commentable_type: @commentable_type, user_id: @user.id}}
            
        end
        assert_redirected_to recipe_url(@recipe)

    end

    test "should get edit" do
        sign_in(@user)
        get edit_comment_url(@comment)
        assert_response :success

    end

    test "should update a comment" do
        sign_in(@user)
        patch comment_url(@comment),params: {comment: { body: "Delicious!"}}

        assert_redirected_to recipe_url(@recipe)

    end

    
    test "should login to update a comment" do
        patch comment_url(@comment),params: {comment: { body: "Delicious!"}}

        assert_redirected_to new_user_session_url

    end

    test "should not update another user comment " do
        sign_in(@user2)
        patch comment_url(@comment),params: {comment: { body: "Delicious!"}}
        assert_redirected_to @recipe

    end


    test "should delete a comment" do
        sign_in(@user)
        assert_difference('Comment.count', -1) do
        delete comment_url(@comment)
        end
        assert_redirected_to recipe_url(@recipe)

    end

    test "should login to delete a comment" do
        assert_difference('Comment.count', 0) do
        delete comment_url(@comment)
        end
        assert_redirected_to new_user_session_url
    end

    test "should not delete another user comment " do
        sign_in(@user2)
        assert_difference('Comment.count', 0) do
            delete comment_url(@comment)
            end
        assert_redirected_to @recipe
    end


end
