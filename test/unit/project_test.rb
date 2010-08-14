require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  setup :activate_authlogic
  setup :valid_project

  def valid_project
    @session = login_as users(:guy)
    @person = Person.make :user => @session.user
    @company = Company.make :person => @person
    plan = Project.plan :company => @company
    @project = Project.new :name => plan[:name],
                           :description => plan[:description],
                           :company => @company
    assert @project.valid?
  end

  test "valid project" do
    assert_difference('Project.count') do
      assert @project.save
    end
  end

  test "invalid project with missing name" do
    @project.name = nil
    assert !@project.valid?
    assert @project.errors.invalid?(:name)
  end

  test "invalid project with missing description" do
    @project.description = nil
    assert !@project.valid?
    assert @project.errors.invalid?(:description)
  end

  test "invalid project with missing company" do
    @project.company = nil
    assert !@project.valid?
    assert @project.errors.invalid?(:company)
  end

  test "invalid project with same name for company" do
    taken = Project.make :company => @company
    @project.name = taken.name
    assert !@project.valid?
    assert @project.errors.invalid?(:name)
  end

  test "associated tasks ordered by list position" do
    assert false
  end

  test "accepts nested attributes for tasks" do
    assert false
  end

  test "rejects nested attributes for tasks with blank values" do
    assert false
  end

  test "rejects nested attributes for tasks with invalid values" do
    assert false
  end
end
