require 'test_helper'

class FollowTest < ActiveSupport::TestCase


    setup do
        @follow = follows(:follow_one)
    end

    test "follower id should be present" do
        @follow.follower_id=""
        assert_not @follow.valid?
    end


    test "followee id should be present" do
        @follow.followee_id=""
        assert_not @follow.valid?
    end

end