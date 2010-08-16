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
    get :new,
        :person_id => @person.to_param
    assert_select 'form[id=new_school][action=?]', person_schools_path(@person) do
      assert_select 'input[type=text][id=school_name][name=?]', 'school[name]'
      assert_select 'input[type=text][id=school_course][name=?]', 'school[course]'
      assert_select 'input[type=text][id=school_result][name=?]', 'school[result]'
      assert_select 'select[id=school_date_from_1i][name=?]', 'school[date_from(1i)]'
      assert_select 'select[id=school_date_to_1i][name=?]', 'school[date_to(1i)]'
    end
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
    assert_difference('School.count') do
      xhr :post,
          :create,
          :person_id => @person.to_param,
          :school => School.plan(:person => @person)
    end
    assert_not_nil assigns(:person)
    assert_not_nil assigns(:school)
    assert_template :create
  end

  test "should not create school on xhr" do
    assert_no_difference('School.count') do
      xhr :post,
          :create,
          :person_id => @person.to_param,
          :school => School.plan(:person => @person,
                                 :name => nil)
    end
    assert_not_nil assigns(:school)
    assert_template :invalid
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
    school = School.make(:person => @person)
    get :edit,
        :person_id => @person.to_param,
        :id => school.to_param
    assert_select 'form[id=?][action=?]', "edit_school_#{school.id}", person_school_path(@person, school) do
      assert_select 'input[type=text][id=school_name][name=?]', 'school[name]'
      assert_select 'input[type=text][id=school_course][name=?]', 'school[course]'
      assert_select 'input[type=text][id=school_result][name=?]', 'school[result]'
      assert_select 'select[id=school_date_from_1i][name=?]', 'school[date_from(1i)]'
      assert_select 'select[id=school_date_to_1i][name=?]', 'school[date_to(1i)]'
    end
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
    put :update,
        :person_id => @person.to_param,
        :id => school.to_param,
        :school => School.plan(:person => @person,
                               :name => nil)
    assert_not_nil assigns(:school)
    assert_template :edit
  end

  test "should update school on xhr" do
    xhr :put,
        :update,
        :person_id => @person.to_param,
        :id => School.make(:person => @person),
        :school => School.plan(:person => @person)
    assert_not_nil assigns(:person)
    assert_not_nil assigns(:school)
    assert_template :update
  end

  test "should not update school on xhr" do
    school = School.make(:person => @person)
    xhr :put,
        :update,
        :person_id => @person.to_param,
        :id => school.to_param,
        :school => School.plan(:person => @person,
                               :name => nil)
    assert_not_nil assigns(:school)
    assert_template :invalid
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
    school = School.make(:person => @person)
    assert_difference('School.count', -1) do
      xhr :delete,
          :destroy,
          :person_id => @person.to_param,
          :id => school.to_param
    end
    assert_not_nil assigns(:person)
    assert_template :destroy
  end

  test "should cancel destroy school" do
    school = School.make(:person => @person)
    assert_no_difference('School.count') do
      delete :destroy,
             :person_id => @person.to_param,
             :id => school.to_param,
             :cancel => 'please'
    end

    assert_redirected_to person_school_path(assigns(:person),
                                            assigns(:school))
  end
end
