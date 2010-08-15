require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup :activate_authlogic

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
    assert_template :index
  end

  test "should get index by name in ascending order" do
    assert false
  end

  test "should get index by email in descending order" do
    assert false
  end

  test "should get page of index" do
    assert false
  end

  test "should get new" do
    login_as users(:guy)
    get :new
    assert_response :success
    assert_not_nil assigns(:person)
    assert_template :new
  end

  test "new form has expected form fields" do
    assert false
  end

  test "should create person" do
    login_as users(:guy)
    assert_difference('Person.count') do
      post :create, :person => Person.plan
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test "should not create person" do
    login_as users(:guy)
    assert_no_difference('Person.count') do
      post :create,
           :person => Person.plan(:name => nil)
    end
    assert_not_nil assigns(:person)
    assert_template :new
  end

  test "should create person on xhr" do
    login_as users(:guy)
    assert_difference('Person.count') do
      xhr :post, :create, :person => Person.plan
    end
    assert_not_nil assigns(:person)
    assert_template :create
  end

  test "should not create person on xhr" do
    assert false
  end

  test "should associate current user with new person" do
    assert false
  end

  test "should show person" do
    get :show,
        :id => people(:homer).to_param
    assert_response :success
    assert_not_nil assigns(:person)
    assert_template :show
  end

  test "should get edit" do
    login_as users(:guy)
    get :edit,
        :id => people(:homer).to_param
    assert_response :success
    assert_not_nil assigns(:person)
    assert_template :edit
  end

  test "edit form has expected form fields" do
    assert false
  end

  test "should update person" do
    session = login_as users(:guy)
    person = Person.make(:user => session.user)
    put :update,
        :id => person.to_param,
        :person => Person.plan

    assert_redirected_to person_path(assigns(:person))
  end

  test "should not update person" do
    session = login_as users(:guy)
    person = Person.make(:user => session.user)
    assert_no_difference('Person.count') do
      put :update,
          :id => person.to_param,
          :person => Person.plan(:name => nil)
    end
    assert_not_nil assigns(:person)
    assert_template :edit
  end

  test "should update person on xhr" do
    assert false
  end

  test "should not update person on xhr" do
    assert false
  end

  test "should get delete confirmation" do
    login_as users(:guy)
    get :delete,
        :id => people(:homer).to_param
    assert_response :success
    assert_not_nil assigns(:person)
    assert_template :delete
  end

  test "should destroy person" do
    login_as users(:guy)
    assert_difference('Person.count', -1) do
      delete :destroy,
             :id => people(:marge).to_param
    end

    assert_redirected_to people_path
  end

  test "should destroy person on xhr" do
    assert false
  end

  test "should cancel destroy person" do
    login_as users(:guy)
    assert_no_difference('Person.count') do
      delete :destroy,
             :id => people(:homer).to_param,
             :cancel => 'please'
    end

    assert_redirected_to person_path(assigns(:person))
  end
end
