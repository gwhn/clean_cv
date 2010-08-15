require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup :activate_authlogic
  setup :make_project

  test "should get index" do
    get :index,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :project_id => @project.to_param
    assert_response :success
    assert_not_nil assigns(:tasks)
    assert_template :index
  end

  test "should get new" do
    get :new,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :project_id => @project.to_param
    assert_response :success
    assert_not_nil assigns(:task)
    assert_template :new
  end

  test "new form has expected form fields" do
    assert false
  end

  test "should create task" do
    assert_difference('Task.count') do
      post :create,
           :person_id => @person.to_param,
           :company_id => @company.to_param,
           :project_id => @project.to_param,
           :task => Task.plan(:project => @project)
    end

    assert_redirected_to person_company_project_task_path(assigns(:person),
                                                          assigns(:company),
                                                          assigns(:project),
                                                          assigns(:task))
  end

  test "should not create task" do
    assert_no_difference('Task.count') do
      post :create,
           :person_id => @person.to_param,
           :company_id => @company.to_param,
           :project_id => @project.to_param,
           :task => Task.plan(:project => @project,
                              :description => nil)
    end
    assert_not_nil assigns(:task)
    assert_template :new
  end

  test "should associate current project with new task" do
    assert false
  end

  test "should show task" do
    get :show,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :project_id => @project.to_param,
        :id => Task.make(:project => @project).to_param
    assert_response :success
    assert_not_nil assigns(:task)
    assert_template :show
  end

  test "should get edit" do
    get :edit,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :project_id => @project.to_param,
        :id => Task.make(:project => @project).to_param
    assert_response :success
    assert_not_nil assigns(:task)
    assert_template :edit
  end

  test "edit form has expected form fields" do
    assert false
  end

  test "should update task" do
    put :update,
        :person_id => @person.to_param,
        :company_id => @company.to_param,
        :project_id => @project.to_param,
        :id => Task.make(:project => @project),
        :task => Task.plan(:project => @project)

    assert_redirected_to person_company_project_task_path(assigns(:person),
                                                          assigns(:company),
                                                          assigns(:project),
                                                          assigns(:task))
  end

  test "should not update task" do
    task = Task.make(:project => @project)
    assert_no_difference('Task.count') do
      put :update,
          :person_id => @person.to_param,
          :company_id => @company.to_param,
          :project_id => @project.to_param,
          :id => task.to_param,
          :task => Task.plan(:project => @project,
                             :description => nil)
    end
    assert_not_nil assigns(:task)
    assert_template :edit
  end

  test "should destroy task" do
    task = Task.make(:project => @project)
    assert_difference('Task.count', -1) do
      delete :destroy,
             :person_id => @person.to_param,
             :company_id => @company.to_param,
             :project_id => @project.to_param,
             :id => task.to_param
    end

    assert_redirected_to person_company_project_tasks_path(assigns(:person), assigns(:company), assigns(:project))
  end

  test "should reposition tasks" do
    assert false
  end
end
