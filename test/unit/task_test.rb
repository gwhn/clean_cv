require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup :activate_authlogic

  test "valid task" do
    assert false
  end

  test "invalid task with missing description" do
    assert false
  end

  test "invalid task with missing project" do
    assert false
  end

  test "invalid task with same description for project" do
    assert false
  end

  test "task acts as list for project" do
    assert false
  end
end
