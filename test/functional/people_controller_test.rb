require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup :activate_authlogic

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
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
    get :show, :id => people(:homer).to_param
    assert_response :success
    assert_not_nil assigns(:person)
  end

  test "should get edit" do
    login_as users(:guy)
    get :edit, :id => people(:homer).to_param
    assert_response :success
    assert_not_nil assigns(:person)
  end

  test "should update person" do
    session = login_as users(:guy)
    person = Person.make(:user => session.user)
    put :update, :id => person.to_param, :person => Person.plan
    assert_redirected_to person_path(assigns(:person))
  end

  test "should destroy person" do
    login_as users(:guy)
    assert_difference('Person.count', -1) do
      delete :destroy, :id => people(:marge).to_param
    end

    assert_redirected_to people_path
  end
end
