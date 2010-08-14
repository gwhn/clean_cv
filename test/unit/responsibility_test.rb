require 'test_helper'

class ResponsibilityTest < ActiveSupport::TestCase
  setup :activate_authlogic

  test "valid responsibility" do
    assert false
  end

  test "invalid responsibility with missing description" do
    assert false
  end

  test "invalid responsibility with missing company" do
    assert false
  end

  test "invalid responsibility with same description for company" do
    assert false
  end

  test "responsibility acts as list for company" do
    assert false
  end
end
