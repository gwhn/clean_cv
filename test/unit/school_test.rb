require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  setup :activate_authlogic

  test "valid school" do
    assert false
  end

  test "invalid school with missing name" do
    assert false
  end

  test "invalid school with missing course" do
    assert false
  end

  test "invalid company with missing date from" do
    assert false
  end

  test "invalid school with missing person" do
    assert false
  end

  test "invalid school with same name for person" do
    assert false
  end

  test "invalid school with date from after date to" do
    assert false
  end
end
