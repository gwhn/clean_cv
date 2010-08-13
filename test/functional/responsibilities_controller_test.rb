require 'test_helper'

class ResponsibilitiesControllerTest < ActionController::TestCase
  setup :activate_authlogic
  setup :make_company

  test "should get index" do
    get :index, :person_id => @person.to_param, :company_id => @company.to_param
    assert_response :success
    assert_not_nil assigns(:responsibilities)
  end

  test "should get new" do
    get :new, :person_id => @person.to_param, :company_id => @company.to_param
    assert_response :success
    assert_not_nil assigns(:responsibility)
  end

  test "should create responsibility" do
    assert_difference('Responsibility.count') do
      post :create, :person_id => @person.to_param, :company_id => @company.to_param,
           :responsibility => Responsibility.plan(:company => @company)
    end

    assert_redirected_to person_company_responsibility_path(assigns(:person), assigns(:company), assigns(:responsibility))
  end

  test "should show responsibility" do
    get :show, :person_id => @person.to_param, :company_id => @company.to_param,
        :id => Responsibility.make(:company => @company).to_param
    assert_response :success
    assert_not_nil assigns(:responsibility)
  end

  test "should get edit" do
    get :edit, :person_id => @person.to_param, :company_id => @company.to_param,
        :id => Responsibility.make(:company => @company).to_param
    assert_response :success
    assert_not_nil assigns(:responsibility)
  end

  test "should update responsibility" do
    put :update, :person_id => @person.to_param, :company_id => @company.to_param,
        :id => Responsibility.make(:company => @company),
        :responsibility => Responsibility.plan(:company => @company)
    assert_redirected_to person_company_responsibility_path(assigns(:person), assigns(:company), assigns(:responsibility))
  end

  test "should destroy responsibility" do
    responsibility = Responsibility.make(:company => @company)
    assert_difference('Responsibility.count', -1) do
      delete :destroy, :person_id => @person.to_param, :company_id => @company.to_param,
             :id => responsibility.to_param
    end

    assert_redirected_to person_company_responsibilities_path(assigns(:person), assigns(:company))
  end
end
