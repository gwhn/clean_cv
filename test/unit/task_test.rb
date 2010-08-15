require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup :activate_authlogic
  setup :valid_task

  def valid_task
    @session = login_as users(:guy)
    @person = Person.make :user => @session.user
    @company = Company.make :person => @person
    @project = Project.make :company => @company
    plan = Task.plan :project => @project
    @task = Task.new :description => plan[:description],
                     :project => @project
    assert @task.valid?
  end

  test "valid task" do
    assert_difference('Task.count') do
      assert @task.save
    end
  end

  test "invalid task with missing description" do
    @task.description = nil
    assert !@task.valid?
    assert @task.errors.invalid?(:description)
  end

  test "invalid task with missing project" do
    @task.project = nil
    assert !@task.valid?
    assert @task.errors.invalid?(:project)
  end

  test "invalid task with same description for project" do
    taken = Task.make :project => @project
    @task.description = taken.description
    assert !@task.valid?
    assert @task.errors.invalid?(:description)
  end

  test "task acts as list for project" do
    assert @task.save
    @project.reload
    assert @project.tasks[0].first?
    assert @project.tasks[0].last?
  end
end
