require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup :activate_authlogic

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => User.plan
    end
    assert_not_nil assigns(:user)
    assert_redirected_to root_path
  end

  test "should get edit" do
    login_as users(:guy)
    get :edit
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should update user" do
    login_as users(:guy)
    put :update, :user => User.plan
    assert_not_nil assigns(:user)
    assert_redirected_to root_path
  end
end
