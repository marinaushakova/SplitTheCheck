require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  setup do
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:restaurants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
      post :create, restaurant: { address: @restaurant.address, city: @restaurant.city, downvote: @restaurant.downvote, name: @restaurant.name, state: @restaurant.state, upvote: @restaurant.upvote, zip: @restaurant.zip }
    end

    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should show restaurant" do
    get :show, id: @restaurant
    assert_response :success
  end

  test "should update restaurant" do
    get :update, id: @restaurant, restaurant: { address: @restaurant.address, city: @restaurant.city, downvote: @restaurant.downvote, name: @restaurant.name, state: @restaurant.state, upvote: @restaurant.upvote, zip: @restaurant.zip }
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end
  
  test "should upvote" do
	get :upvote, restaurant_id: @restaurant.id
	assert_equal 2, Restaurant.find(@restaurant.id).upvote
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end
  
  test "should downvote" do
	get :downvote, restaurant_id: @restaurant.id
	assert_equal 2, Restaurant.find(@restaurant.id).downvote
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

end
