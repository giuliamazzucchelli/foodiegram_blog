require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    def setup
        @category = Category.create(name: "Dessert")
    end

    test "category should be valid" do
        assert @category.valid?
    end

    test "name should be present" do
        @category.name = ""
        assert_not @category.valid?
    end

    test "name should not be too short" do
        @category.name = "a" * 2
        assert_not @category.valid?
    end

    test "name should not be too long" do
        @category.name = "a" * 31
        assert_not @category.valid?
    end
end