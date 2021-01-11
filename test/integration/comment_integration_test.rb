require 'test_helper'

class CommentIntegrationTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
        @recipe = recipes(:recipe_one)
        @comment = comments(:one)

    end

    test "should show a recipe and its comments" do
        get recipe_url(@recipe)
        assert_response :success
        assert_select 'h5.card-title','1 comment'
    end

end

