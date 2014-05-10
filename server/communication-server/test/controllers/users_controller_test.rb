require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get identify" do
    get :identify
    assert_response :success
  end

end
