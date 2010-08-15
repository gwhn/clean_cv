require 'test_helper'

class SchoolsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  setup :make_person

  test "should get index" do
    get :index,
        :person_id => @person.to_param
    assert_response :success
    assert_not_nil assigns(:schools)
    assert_template :index
  end

  test "should get new" do
    get :new,
        :person_id => @person.to_param
    assert_response :success
    assert_not_nil assigns(:school)
    assert_template :new
  end

  test "new form has expected form fields" do
    assert false
  end

  test "should create school" do
    assert_difference('School.count') do
      post :create,
           :person_id => @person.to_param,
           :school => School.plan(:person => @person)
    end

    assert_redirected_to person_school_path(assigns(:person),
                                            assigns(:school))
  end

  test "should not create school" do
    assert_no_difference('School.count') do
      post :create,
           :person_id => @person.to_param,
           :school => School.plan(:person => @person,
                                  :name => nil)
    end
    assert_not_nil assigns(:school)
    assert_template :new
  end

  test "should create school on xhr" do
    assert false
  end

  test "should not create school on xhr" do
    assert false
  end

  test "should associate current person with new school" do
    assert false
  end

  test "should show school" do
    get :show,
        :person_id => @person.to_param,
        :id => School.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:school)
    assert_template :show
  end

  test "should get edit" do
    get :edit,
        :person_id => @person.to_param,
        :id => School.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:school)
    assert_template :edit
  end

  test "edit form has expected form fields" do
    assert false
  end

  test "should update school" do
    put :update,
        :person_id => @person.to_param,
        :id => School.make(:person => @person),
        :school => School.plan(:person => @person)
    
    assert_redirected_to person_school_path(assigns(:person),
                                            assigns(:school))
  end

  test "should not update school" do
    school = School.make(:person => @person)
    assert_no_difference('School.count') do
      put :update,
          :person_id => @person.to_param,
          :id => school.to_param,
          :school => School.plan(:person => @person,
                                 :name => nil)
    end
    assert_not_nil assigns(:school)
    assert_template :edit
  end

  test "should update school on xhr" do
    assert false
  end

  test "should not update school on xhr" do
    assert false
  end

  test "should get delete confirmation" do
    get :delete,
        :person_id => @person.to_param,
        :id => School.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:school)
    assert_template :delete
  end

  test "should destroy school" do
    school = School.make(:person => @person)
    assert_difference('School.count', -1) do
      delete :destroy,
             :person_id => @person.to_param,
             :id => school.to_param
    end

    assert_redirected_to person_schools_path(assigns(:person))
  end

  test "should destroy school on xhr" do
    assert false
  end

  test "should cancel destroy school" do
    assert false
  end
end
