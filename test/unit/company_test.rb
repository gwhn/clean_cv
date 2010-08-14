require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  setup :activate_authlogic
  setup :valid_company

  def valid_company
    @session = login_as users(:guy)
    @person = Person.make :user => @session.user
    plan = Company.plan :person => @person
    @company = Company.new :name => plan[:name],
                           :role => plan[:role],
                           :business_type => plan[:business_type],
                           :start_date => plan[:start_date],
                           :person => @person
    assert @company.valid?
  end

  test "valid company" do
    assert_difference('Company.count') do
      assert @company.save
    end
  end

  test "invalid company with missing name" do
    @company.name = nil
    assert !@company.valid?
    assert @company.errors.invalid?(:name)
  end

  test "invalid company with missing role" do
    @company.role = nil
    assert !@company.valid?
    assert @company.errors.invalid?(:role)
  end

  test "invalid company with missing business type" do
    @company.business_type = nil
    assert !@company.valid?
    assert @company.errors.invalid?(:business_type)
  end

  test "invalid company with missing start date" do
    @company.start_date = nil
    assert !@company.valid?
    assert @company.errors.invalid?(:start_date)
  end

  test "invalid company with missing person" do
    @company.person = nil
    assert !@company.valid?
    assert @company.errors.invalid?(:person)
  end

  test "invalid company with same name for person" do
    taken = Company.make :person => @person
    @company.name = taken.name
    assert !@company.valid?
    assert @company.errors.invalid?(:name)
  end

  test "invalid company with start date after end date" do
    @company.end_date = @company.start_date - 1.day
    assert !@company.valid?
    assert @company.errors.invalid?(:start_date)
  end

  test "associated responsibilities ordered by list position" do
    (1..10).each do
      @last = Responsibility.make :company => @company
    end
    @company.reload.responsibilities.each do |r|
      assert r.position <= @last.position
    end
  end

  test "accepts nested attributes for projects" do
    assert @company.save
    attrs = @company.attributes
    attrs[:projects_attributes] = {}
    count = 10
    (1..count).each do |i|
      attrs[:projects_attributes][i.to_s] = Project.plan
    end
    assert @company.update_attributes(attrs)
    assert_equal count, @company.reload.projects.count
  end

  test "rejects nested attributes for projects with invalid values" do
    assert @company.save
    attrs = @company.attributes
    attrs[:projects_attributes] = {}
    attrs[:projects_attributes][:invalid] = Project.plan :name => nil
    assert !@company.update_attributes(attrs)
    assert @company.errors.invalid?(:projects)
  end

  test "accepts nested attributes for responsibilities" do
    assert @company.save
    attrs = @company.attributes
    attrs[:responsibilities_attributes] = {}
    count = 10
    (1..count).each do |i|
      attrs[:responsibilities_attributes][i.to_s] = Responsibility.plan
    end
    assert @company.update_attributes(attrs)
    assert_equal count, @company.reload.responsibilities.count
  end

  test "rejects nested attributes for responsibilities with invalid values" do
    assert @company.save
    attrs = @company.attributes
    attrs[:responsibilities_attributes] = {}
    attrs[:responsibilities_attributes][:invalid] = Responsibility.plan :description => nil
    assert !@company.update_attributes(attrs)
    assert @company.errors.invalid?(:responsibilities)
  end
end
