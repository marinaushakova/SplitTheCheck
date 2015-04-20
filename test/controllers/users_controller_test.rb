require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should show user" do
    sign_in @user
    get :show, id: @user
    assert_response :success
  end

end
