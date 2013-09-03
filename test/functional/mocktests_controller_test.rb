require 'test_helper'

class MocktestsControllerTest < ActionController::TestCase
  setup do
    @mocktest = mocktests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mocktests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mocktest" do
    assert_difference('Mocktest.count') do
      post :create, mocktest: { description: @mocktest.description, name: @mocktest.name }
    end

    assert_redirected_to mocktest_path(assigns(:mocktest))
  end

  test "should show mocktest" do
    get :show, id: @mocktest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mocktest
    assert_response :success
  end

  test "should update mocktest" do
    put :update, id: @mocktest, mocktest: { description: @mocktest.description, name: @mocktest.name }
    assert_redirected_to mocktest_path(assigns(:mocktest))
  end

  test "should destroy mocktest" do
    assert_difference('Mocktest.count', -1) do
      delete :destroy, id: @mocktest
    end

    assert_redirected_to mocktests_path
  end
end
