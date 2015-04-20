require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
  end

  test "should create comment" do
    sign_in User.first
    assert_difference('Comment.count') do
      post :create, comment: { message: @comment.message, restaurant_id: @comment.restaurant_id, user_id: @comment.user_id }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

end
