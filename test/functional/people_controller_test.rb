require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup :activate_authlogic

  test "should get index" do
    people = [people(:homer), people(:marge)]
    Person.expects(:find).returns(people)
    get :index
    assert_response :success
    assert_equal people, assigns(:people)
  end

  test "should get new" do
    login_as users(:guy)
    get :new
    assert_response :success
    assert_not_nil assigns(:person)
  end

  test "should create person" do
    login_as users(:guy)
    assert_difference('Person.count') do
      post :create, :person => Person.plan
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test "should show person" do
    get :show, :id => people(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => people(:one).to_param
    assert_response :success
  end

  test "should update person" do
    put :update, :id => people(:one).to_param, :person => { }
    assert_redirected_to person_path(assigns(:person))
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, :id => people(:one).to_param
    end

    assert_redirected_to people_path
  end
end
