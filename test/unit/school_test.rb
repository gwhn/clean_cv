require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  setup :activate_authlogic
  setup :valid_school

  def valid_school
    @session = login_as users(:guy)
    @person = Person.make :user => @session.user
    plan = School.plan :person => @person
    @school = School.new :name => plan[:name],
                         :course => plan[:course],
                         :date_from => plan[:date_from],
                         :person => @person
    assert @school.valid?
  end

  test "valid school" do
    assert_difference('School.count') do
      assert @school.save
    end
  end

  test "invalid school with missing name" do
    @school.name = nil
    assert !@school.valid?
    assert @school.errors.invalid?(:name)
  end

  test "invalid school with missing course" do
    @school.course = nil
    assert !@school.valid?
    assert @school.errors.invalid?(:course)
  end

  test "invalid company with missing date from" do
    @school.date_from = nil
    assert !@school.valid?
    assert @school.errors.invalid?(:date_from)
  end

  test "invalid school with missing person" do
    @school.person = nil
    assert !@school.valid?
    assert @school.errors.invalid?(:person)
  end

  test "invalid school with same name for person" do
    taken = School.make :person => @person
    @school.name = taken.name
    assert !@school.valid?
    assert @school.errors.invalid?(:name)
  end

  test "invalid school with date from after date to" do
    @school.date_to = @school.date_from - 1.day
    assert !@school.valid?
    assert @school.errors.invalid?(:date_from)
  end
end
