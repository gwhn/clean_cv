require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  setup :activate_authlogic

  test "valid project" do
    assert false
  end

  test "invalid project with missing name" do
    assert false
  end

  test "invalid project with missing description" do
    assert false
  end

  test "invalid project with missing company" do
    assert false
  end

  test "invalid project with same name for company" do
    assert false
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
