require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup :activate_authlogic
  setup :make_person

  test "should get index" do
    get :index, :person_id => @person.to_param
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get new" do
    get :new, :person_id => @person.to_param
    assert_response :success
    assert_not_nil assigns(:company)
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, :person_id => @person.to_param,
           :company => Company.plan(:person => @person)
    end

    assert_redirected_to person_company_path(assigns(:person), assigns(:company))
  end

  test "should show company" do
    get :show, :person_id => @person.to_param,
        :id => Company.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:company)
  end

  test "should get edit" do
    get :edit, :person_id => @person.to_param,
        :id => Company.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:company)
  end

  test "should update company" do
    put :update, :person_id => @person.to_param,
        :id => Company.make(:person => @person),
        :skill => Company.plan(:person => @person)
    assert_redirected_to person_company_path(assigns(:person), assigns(:company))
  end

  test "should destroy company" do
    company = Company.make(:person => @person)
    assert_difference('Company.count', -1) do
      delete :destroy, :person_id => @person.to_param,
             :id => company.to_param
    end

    assert_redirected_to person_companies_path(assigns(:person))
  end
end
