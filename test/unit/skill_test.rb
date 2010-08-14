require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  setup :activate_authlogic

  test "valid skill" do
    assert false
  end

  test "invalid skill with missing name" do
    assert false
  end

  test "invalid skill with missing level" do
    assert false
  end

  test "invalid skill with missing description" do
    assert false
  end

  test "invalid skill with missing person" do
    assert false
  end

  test "invalid skill with same name for person" do
    assert false
  end

  test "skill acts as list for person" do
    assert false
  end
end
