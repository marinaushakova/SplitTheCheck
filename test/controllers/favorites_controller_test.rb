require 'test_helper'

class FavoritesControllerTest < ActionController::TestCase
  setup do
    @favorite = favorites(:one)
  end

  test "should create favorite" do
    sign_in users(:two)
    assert_difference('Favorite.count') do
      post :create, favorite: { restaurant_id: 1, user_id: users(:two) }
    end

    assert_redirected_to favorite_path(assigns(:favorite))
  end

  #test "should destroy favorite" do
  #  assert_difference('Favorite.count', -1) do
  #    delete :destroy, id: @favorite
  #  end

  #  assert_redirected_to restaurant_path
  #end
end
