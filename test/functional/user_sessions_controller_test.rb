require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user_session)
  end

  test "should create user session" do
    user = User.make
    post :create, :user_session => {:username => user.username, :password => user.password}
    assert_not_nil assigns(:user_session)
                                 
    assert_redirected_to root_path
  end

  test "should destroy user session" do
    delete :destroy, :id => login_as(users(:guy))
    assert_not_nil assigns(:user_session)

    assert_redirected_to root_path
  end
end
