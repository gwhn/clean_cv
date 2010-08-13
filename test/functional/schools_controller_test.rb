require 'test_helper'

class SchoolsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  setup :make_person

  test "should get index" do
    get :index, :person_id => @person.to_param
    assert_response :success
    assert_not_nil assigns(:schools)
  end

  test "should get new" do
    get :new, :person_id => @person.to_param
    assert_response :success
    assert_not_nil assigns(:school)
  end

  test "should create school" do
    assert_difference('School.count') do
      post :create, :person_id => @person.to_param,
           :school => School.plan(:person => @person)
    end

    assert_redirected_to person_schools_path(assigns(:person))
  end

  test "should show school" do
    get :show, :person_id => @person.to_param,
        :id => School.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:school)
  end

  test "should get edit" do
    get :edit, :person_id => @person.to_param,
        :id => School.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:school)
  end

  test "should update school" do
    put :update, :person_id => @person.to_param,
        :id => School.make(:person => @person),
        :school => School.plan(:person => @person)
    assert_redirected_to person_schools_path(assigns(:person))
  end

  test "should destroy school" do
    school = School.make(:person => @person)
    assert_difference('School.count', -1) do
      delete :destroy, :person_id => @person.to_param,
             :id => school.to_param
    end

    assert_redirected_to person_schools_path(assigns(:person))
  end
end
