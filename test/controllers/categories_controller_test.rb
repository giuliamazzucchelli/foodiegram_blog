require 'test_helper'


class CategoryControllerTest < ActionDispatch::IntegrationTest
    def setup
        @category = Category.create(name: "Dessert")
    end

    
    test "should show category" do
        get category_url(@category)
        assert_response :success
    end

    test "should get index" do
        get categories_url
        assert_response :success
    end

end