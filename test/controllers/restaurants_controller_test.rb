require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  setup do
    @restaurant = restaurants(:one)
    @votes = votes
    @comments = comments
    @favorites = favorites
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:restaurants)
  end

  test "should get new" do
    sign_in User.first
    get :new
    assert_response :success
  end

  test "should create restaurant" do
    sign_in User.first
    assert_difference('Restaurant.count') do
      post :create, restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, state: @restaurant.state, zip: @restaurant.zip }
    end

    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should show restaurant" do
    get :show , id: @restaurant
    assert_response :success
  end

  test "should update restaurant" do
    sign_in User.first
    get :update, id: @restaurant, restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, state: @restaurant.state, zip: @restaurant.zip }
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end
  
  test "should upvote" do
    sign_in User.first
	get :upvote, restaurant_id: @restaurant.id
	assert_equal 1, Vote.where(:restaurant_id => @restaurant.id, :vote => true).count
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end
  
  test "should downvote" do
    sign_in User.first
	get :downvote, restaurant_id: @restaurant.id
	assert_equal 1, Vote.where(:restaurant_id => @restaurant.id, :vote => false).count
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end
  
  test "should count upvotes" do
    sign_in User.first
	5.times { get :upvote, restaurant_id: @restaurant.id }
	assert_equal 5, Vote.where(:restaurant_id => @restaurant.id, :vote => true).count
  end
  
  test "should count downvotes" do
    sign_in User.first
	3.times { get :downvote, restaurant_id: @restaurant.id }
	assert_equal 3, Vote.where(:restaurant_id => @restaurant.id, :vote => false).count
  end

end
