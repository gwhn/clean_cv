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

  test "invalid project with same name for company" do
    taken = Project.make :company => @company
    @project.name = taken.name
    assert !@project.valid?
    assert @project.errors.invalid?(:name)
  end

  test "associated tasks ordered by list position" do
    (1..10).each do
      @last = Task.make :project => @project
    end
    @project.reload.tasks.each do |t|
      assert t.position <= @last.position
    end
  end

  test "accepts nested attributes for tasks" do
    assert @project.save
    attrs = @project.attributes
    attrs[:tasks_attributes] = {}
    count = 10
    (1..count).each do |i|
      attrs[:tasks_attributes][i.to_s] = Task.plan
    end
    assert @project.update_attributes(attrs)
    assert_equal count, @project.reload.tasks.count
  end

  test "rejects nested attributes for tasks with blank values" do
    assert @project.save
    attrs = @project.attributes
    attrs[:tasks_attributes] = {}
    attrs[:tasks_attributes][:blank] = Task.plan :description => nil,
                                                 :project => nil
    assert @project.update_attributes(attrs)
    assert @project.reload.tasks.count == 0
  end

  test "rejects nested attributes for tasks with invalid values" do
    assert @project.save
    attrs = @project.attributes
    attrs[:tasks_attributes] = {}
    attrs[:tasks_attributes][:invalid] = Task.plan :description => nil,
                                                   :project => @project
    puts attrs.to_json
    assert !@project.update_attributes(attrs)
    assert @project.errors.invalid?(:tasks)
  end

  test "removes nested attributes for tasks marked to be destroyed" do
    assert @project.save
    attrs = @project.attributes
    task = Task.make :project => @project
    assert @project.reload.tasks.count == 1
    attrs[:tasks_attributes] = {}
    attrs[:tasks_attributes][:remove] = {:id => task.id, '_destroy' => '1'}
    assert @project.update_attributes(attrs)
    assert @project.reload.tasks.count == 0
  end
end
