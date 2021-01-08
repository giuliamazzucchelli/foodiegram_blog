require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
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
