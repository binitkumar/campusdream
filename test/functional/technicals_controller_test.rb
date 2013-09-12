require 'test_helper'

class TechnicalsControllerTest < ActionController::TestCase
  test "should get books" do
    get :books
    assert_response :success
  end

  test "should get projects" do
    get :projects
    assert_response :success
  end

end
