
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @User1 = User.new(email: "userdemo@example.com",password: "password",username: "User1",bio: "Hello")
    
  end

  test "user should be valid" do
    assert @User1.valid?
  end

  test "email should be present" do
    @User1.email=" "
    assert_not @User1.valid?
  end

  test "email should be unique" do
    @User1.save
    @User2 = User.new(email: @User1.email, password: "password", username: "User2")
    assert_not @User2.valid?
  end

  test "email should be valid" do
    @User1.email = "email"
    assert_not @User1.valid?
  end

  test "password should not be too short" do
    @User1.password = "pwd"
    assert_not @User1.valid?
  end

  test "password should be present" do
    @User1.password= " "
    assert_not @User1.valid?
  end

  test "username should be present" do
    @User1.username=" "
    assert_not @User1.valid?
  end

  test "username should be unique" do
    @User1.save
    @User2 = User.new(email: "user2@example.com", password: "password", username: @User1.username)
    assert_not @User2.valid?
  end

  test "username should not be too short" do
    @User1.username = "aa"
    assert_not @User1.valid?
  end

  test "username should not be too long" do
    @User1.username = "a" * 26
    assert_not @User1.valid?
  end

  test "bio should not be too long" do
    @User1.bio = "a" * 161
    assert_not @User1.valid?
  end

  test "avatar should be image format" do
    @User1.avatar.attach(io: File.open("C:/users/fabio/Desktop/food.txt"),filename:"food.txt")
    assert_not @User1.valid?
  end

  test "avatar size should be valid" do
    @User1.avatar.attach(io: File.open("C:/users/fabio/Desktop/food_largesize.jpg"),filename:"food.jpg")
    assert_not @User1.valid?
  end

  test "avatar should be valid " do
    @User1.avatar.attach(io: File.open("C:/users/fabio/Desktop/cookies.jpg"),filename:"food.jpg")
    assert @User1.valid?
  end
  

end