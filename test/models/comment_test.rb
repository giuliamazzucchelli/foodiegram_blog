require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email:"userdemo@example.com",password:"password",username:"UserDemo",bio:"Hello")
    @recipe = Recipe.create( title: "Chocolate Cookies",
        servings: 4,
        prep_time: 15,
        cook_time: 10,
        ingredients: "1 cup flour 1/2 cup cane sugar 1/2 cup  white sugar 1 egg, 1 pinch of salt 1/4 cup chocolate chips ",
        directions: "Melt the butter using a double-boiler.Mix the dry ingredients then add the egg and the butter , put in the hoven for 10 minutes. Let the cookies cool before serving.",
        user_id: @user.id)
    @comment = Comment.create(body:"Good!",commentable_id: @recipe.id, user_id: @user.id,commentable_type:"Recipe")
  end


  test "comment should be valid" do
    
    assert @comment.valid?
  end

  test "body should be present" do
    @comment.body=""
    assert_not @comment.valid?
  end

  test "body should not be too short" do
    @comment.body = "a" * 2
    assert_not @comment.valid?
  end

  test "body should not be too long" do
    @comment.body = "a" * 151
    assert_not @comment.valid?
  end
end
