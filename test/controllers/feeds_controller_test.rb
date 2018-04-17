require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get next_page" do
    get :next_page
    assert_response :success
  end

end
