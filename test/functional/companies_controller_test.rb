require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup :activate_authlogic
  setup :make_person

  test "should get index" do
    get :index, :person_id => @person.to_param
    assert_response :success
    assert_not_nil assigns(:companies)
    assert_template :index
  end

  test "should get new" do
    get :new, :person_id => @person.to_param
    assert_response :success
    assert_not_nil assigns(:company)
    assert_template :new
  end

  test "new form has expected form fields" do
    assert false
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, :person_id => @person.to_param,
           :company => Company.plan(:person => @person)
    end

    assert_redirected_to person_company_path(assigns(:person), assigns(:company))
  end

  test "should not create company" do
    assert false
  end

  test "should create company on xhr" do
    assert false
  end

  test "should not create company on xhr" do
    assert false
  end

  test "should create company with nested responsibilities" do
    assert false
  end

  test "should create company ignoring blank nested responsibilities" do
    assert false
  end

  test "should create company with nested projects" do
    assert false
  end

  test "should create company ignoring blank nested project" do
    assert false
  end

  test "should associate current person with new company" do
    assert false
  end

  test "should show company" do
    get :show, :person_id => @person.to_param,
        :id => Company.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:company)
    assert_template :show
  end

  test "should get edit" do
    get :edit, :person_id => @person.to_param,
        :id => Company.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:company)
    assert_template :edit
  end

  test "edit form has expected form fields" do
    assert false
  end

  test "should update company" do
    put :update, :person_id => @person.to_param,
        :id => Company.make(:person => @person),
        :skill => Company.plan(:person => @person)

    assert_redirected_to person_company_path(assigns(:person), assigns(:company))
  end

  test "should not update company" do
    assert false
  end

  test "should update company on xhr" do
    assert false
  end

  test "should not update company on xhr" do
    assert false
  end

  test "should update company with nested responsibilities" do
    assert false
  end

  test "should update company ignoring blank nested responsibilities" do
    assert false
  end

  test "should update company with nested projects" do
    assert false
  end

  test "should update company ignoring blank nested projects" do
    assert false
  end

  test "should get delete confirmation" do
    login_as users(:guy)
    get :delete, :person_id => @person.to_param,
        :id => Company.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:company)
    assert_template :delete
  end

  test "should destroy company" do
    company = Company.make(:person => @person)
    assert_difference('Company.count', -1) do
      delete :destroy, :person_id => @person.to_param,
             :id => company.to_param
    end

    assert_redirected_to person_companies_path(assigns(:person))
  end

  test "should destroy company on xhr" do
    assert false
  end

  test "should cancel destroy company" do
    assert false
  end
end
