require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  setup :activate_authlogic

  test "valid company" do
    assert false
  end

  test "invalid company with missing name" do
    assert false
  end

  test "invalid company with missing role" do
    assert false
  end

  test "invalid company with missing business type" do
    assert false
  end

  test "invalid company with missing start date" do
    assert false
  end

  test "invalid company with missing person" do
    assert false
  end

  test "invalid company with same name for person" do
    assert false
  end

  test "invalid company with start date after end date" do
    assert false
  end

  test "associated responsibilities ordered by list position" do
    assert false
  end

  test "accepts nested attributes for projects" do
    assert false
  end

  test "rejects nested attributes for projects with blank values" do
    assert false
  end

  test "rejects nested attributes for projects with invalid values" do
    assert false
  end

  test "accepts nested attributes for responsibilities" do
    assert false
  end

  test "rejects nested attributes for responsibilities with blank values" do
    assert false
  end
  
  test "rejects nested attributes for responsibilities with invalid values" do
    assert false
  end
end
