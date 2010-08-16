require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  setup :make_company

  test "should get index" do
    get :index,
        :person_id => @person.to_param,
        :company_id => @company.to_param
    assert_response :success
    assert_not_nil assigns(:projects)
    assert_template :index
  end

  test "should get new" do
    get :new,
        :person_id => @person.to_param,
        :company_id => @company.to_param
    assert_response :success
    assert_not_nil assigns(:project)
    assert_template :new
  end

  test "new form has expected form fields" do
    Skill.make :person => @person
    get :new,
        :person_id => @person.to_param,
        :company_id => @company.to_param
    assert_select 'form[id=new_project][action=?]', person_company_projects_path(@person, @company) do
      assert_select 'input[type=text][id=project_name][name=?]', 'project[name]'
      assert_select 'textarea[id=project_description][name=?]', 'project[description]'
      assert_select 'input[type=hidden][name=?]', 'project[skill_ids][]', :count => @person.skills.count
      assert_select 'input[type=checkbox][name=?]', 'project[skill_ids][]', :count => @person.skills.count
    end
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create,
           :person_id => @person.to_param,
           :company_id => @company.to_param,
           :project => Project.plan(:company => @company)
    end

    assert_redirected_to person_company_project_path(assigns(:person),
                                                     assigns(:company),
                                                     assigns(:project))
  end

  test "should not create project" do
    assert_no_difference('Project.count') do
      post :create,
           :person_id => @person.to_param,
           :company_id => @company.to_param,
           :project => Project.plan(:company => @company,
                                    :name => nil)
    end
    assert_not_nil assigns(:project)
    assert_template :new
  end

  test "should create project on xhr" do
    assert_difference('Project.count') do
      xhr :post,
          :create,
          :person_id => @person.to_param,
          :company_id => @company.to_param,
          :project => Project.plan(:company => @company)
    end
    assert_not_nil assigns(:person)
    assert_not_nil assigns(:company)
    assert_not_nil assigns(:project)
    assert_template :create
  end

  test "should not create project on xhr" do
    assert_no_difference('Project.count') do
      xhr :post,
          :create,
          :person_id => @person.to_param,
          :company_id => @company.to_param,
          :project => Project.plan(:company => @company,
                                   :name => nil)
    end
    assert_not_nil assigns(:project)
    assert_template :invalid
  end

  test "should associate current company with new project" do
    assert false
  end

  test "should show project" do
    get :show,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :id => Project.make(:company => @company).to_param
    assert_response :success
    assert_not_nil assigns(:project)
    assert_template :show
  end

  test "should get edit" do
    get :edit,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :id => Project.make(:company => @company).to_param
    assert_response :success
    assert_not_nil assigns(:project)
    assert_template :edit
  end

  test "edit form has expected form fields" do
    assert false
  end

  test "should update project" do
    put :update,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :id => Project.make(:company => @company),
        :project => Project.plan(:company => @company)

    assert_redirected_to person_company_project_path(assigns(:person),
                                                     assigns(:company),
                                                     assigns(:project))
  end

  test "should not update project" do
    project = Project.make(:company => @company)
    put :update,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :id => project.to_param,
        :project => Project.plan(:company => @company,
                                 :name => nil)
    assert_not_nil assigns(:project)
    assert_template :edit
  end

  test "should update project on xhr" do
    xhr :put,
        :update,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :id => Project.make(:company => @company),
        :project => Project.plan(:company => @company)
    assert_not_nil assigns(:person)
    assert_not_nil assigns(:company)
    assert_not_nil assigns(:project)
    assert_template :update
  end

  test "should not update project on xhr" do
    project = Project.make(:company => @company)
    xhr :put,
        :update,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :id => project.to_param,
        :project => Project.plan(:company => @company,
                                 :name => nil)
    assert_not_nil assigns(:project)
    assert_template :invalid
  end

  test "should get delete confirmation" do
    get :delete,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :id => Project.make(:company => @company).to_param
    assert_response :success
    assert_not_nil assigns(:project)
    assert_template :delete
  end

  test "should destroy project" do
    project = Project.make(:company => @company)
    assert_difference('Project.count', -1) do
      delete :destroy,
             :person_id => @person.to_param,
             :company_id => @company.to_param,
             :id => project.to_param
    end

    assert_redirected_to person_company_projects_path(assigns(:person),
                                                      assigns(:company))
  end

  test "should destroy company on xhr" do
    project = Project.make(:company => @company)
    assert_difference('Project.count', -1) do
      xhr :delete,
          :destroy,
          :person_id => @person.to_param,
          :company_id => @company.to_param,
          :id => project.to_param
    end
    assert_not_nil assigns(:person)
    assert_not_nil assigns(:company)
    assert_template :destroy
  end

  test "should cancel destroy company" do
    project = Project.make(:company => @company)
    assert_no_difference('Project.count') do
      delete :destroy,
             :person_id => @person.to_param,
             :company_id => @company.to_param,
             :id => project.to_param,
             :cancel => 'please'
    end

    assert_redirected_to person_company_project_path(assigns(:person),
                                                     assigns(:company),
                                                     assigns(:project))
  end
end
