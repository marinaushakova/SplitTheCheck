require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  test "restaurant attributes must not be empty" do
    restaurant = Restaurant.new
    assert restaurant.invalid?
    assert restaurant.errors[:name].any?
    assert restaurant.errors[:address].any?
    assert restaurant.errors[:city].any?
    assert restaurant.errors[:state].any?
    assert restaurant.errors[:zip].any?
  end
  
  test "zip must be in xxxxx or xxxxx-xxxx format" do
    restaurant = Restaurant.new(name:		"Three brothers",
								address:	"1111 Main Rd",
								city:		"Atlanta",
								state:		"Georgia",
								zip:		"1234")
	assert restaurant.invalid?
	assert_equal ["should be in 12345 or 12345-1234 format"],
		restaurant.errors[:zip]
    
    restaurant.zip = "abcde"
    assert restaurant.invalid?
    
    restaurant.zip = "55555"
    assert restaurant.valid?
    
    restaurant.zip = "11111-2222"
    assert restaurant.valid?
  end
end
