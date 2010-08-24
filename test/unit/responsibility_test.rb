require 'test_helper'

class ResponsibilityTest < ActiveSupport::TestCase
  setup :activate_authlogic
  setup :valid_responsibility

  def valid_responsibility
    @session = login_as users(:guy)
    @person = Person.make :user => @session.user
    @company = Company.make :person => @person
    plan = Responsibility.plan :company => @company
    @responsibility = Responsibility.new :description => plan[:description],
                                         :company => @company
    assert @responsibility.valid?
  end

  test "valid responsibility" do
    assert_difference('Responsibility.count') do
      assert @responsibility.save
    end
  end

  test "invalid responsibility with missing description" do
    @responsibility.description = nil
    assert !@responsibility.valid?
    assert @responsibility.errors.invalid?(:description)
  end

  test "invalid responsibility with same description for company" do
    taken = Responsibility.make :company => @company
    @responsibility.description = taken.description
    assert !@responsibility.valid?
    assert @responsibility.errors.invalid?(:description)
  end

  test "responsibility acts as list for company" do
    assert @responsibility.save
    @company.reload
    assert @company.responsibilities[0].first?
    assert @company.responsibilities[0].last?
  end
end
