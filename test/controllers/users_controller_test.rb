require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = User.first
    @restaurant = restaurants(:one)
  end

  test "should show user" do
    sign_in @user
    get :show, id: @user
    assert_response :success
  end
  
  test "should get user summary" do
    sign_in @user
    get :show, id: @user
    assert_equal 2, Vote.where(:user => User.first).count
    assert_equal 2, Favorite.where(:user => User.first).count
    assert_equal 1, Comment.where(:user => User.first).count
    assert_response :success
  end

end
