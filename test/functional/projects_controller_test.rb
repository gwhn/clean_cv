require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  setup :make_company

  test "should get index" do
    get :index, :person_id => @person.to_param, :company_id => @company.to_param
    assert_response :success
    assert_not_nil assigns(:projects)
    assert_template :index
  end

  test "should get new" do
    get :new, :person_id => @person.to_param, :company_id => @company.to_param
    assert_response :success
    assert_not_nil assigns(:project)
    assert_template :new
  end

  test "new form has expected form fields" do
    assert false
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, :person_id => @person.to_param, :company_id => @company.to_param,
           :project => Project.plan(:company => @company)
    end

    assert_redirected_to person_company_project_path(assigns(:person), assigns(:company), assigns(:project))
  end

  test "should not create project" do
    assert false
  end

  test "should create project on xhr" do
    assert false
  end

  test "should not create project on xhr" do
    assert false
  end

  test "should create project with nested tasks" do
    assert false
  end

  test "should create project ignoring blank nested tasks" do
    assert false
  end

  test "should associate current company with new project" do
    assert false
  end

  test "should show project" do
    get :show, :person_id => @person.to_param, :company_id => @company.to_param,
        :id => Project.make(:company => @company).to_param
    assert_response :success
    assert_not_nil assigns(:project)
    assert_template :show
  end

  test "should get edit" do
    get :edit, :person_id => @person.to_param, :company_id => @company.to_param,
        :id => Project.make(:company => @company).to_param
    assert_response :success
    assert_not_nil assigns(:project)
    assert_template :edit
  end

  test "edit form has expected form fields" do
    assert false
  end

  test "should update project" do
    put :update, :person_id => @person.to_param, :company_id => @company.to_param,
        :id => Project.make(:company => @company),
        :project => Project.plan(:company => @company)
    
    assert_redirected_to person_company_project_path(assigns(:person), assigns(:company), assigns(:project))
  end

  test "should not update project" do
    assert false
  end

  test "should update project on xhr" do
    assert false
  end

  test "should not update project on xhr" do
    assert false
  end

  test "should update project with nested tasks" do
    assert false
  end

  test "should update project ignoring blank nested tasks" do
    assert false
  end

  test "should get delete confirmation" do
    login_as users(:guy)
    get :delete, :person_id => @person.to_param, :company_id => @company.to_param,
        :id => Project.make(:company => @company).to_param
    assert_response :success
    assert_not_nil assigns(:project)
    assert_template :delete
  end

  test "should destroy project" do
    project = Project.make(:company => @company)
    assert_difference('Project.count', -1) do
      delete :destroy, :person_id => @person.to_param, :company_id => @company.to_param,
             :id => project.to_param
    end

    assert_redirected_to person_company_projects_path(assigns(:person), assigns(:company))
  end

  test "should destroy company on xhr" do
    assert false
  end

  test "should cancel destroy company" do
    assert false
  end
end
