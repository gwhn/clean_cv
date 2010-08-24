require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  setup :activate_authlogic
  setup :valid_skill

  def valid_skill
    @session = login_as users(:guy)
    @person = Person.make :user => @session.user
    plan = Skill.plan :person => @person
    @skill = Skill.new :name => plan[:name],
                       :level => plan[:level],
                       :description => plan[:description],
                       :person => @person
    assert @skill.valid?
  end

  test "valid skill" do
    assert_difference('Skill.count') do
      assert @skill.save
    end
  end

  test "invalid skill with missing name" do
    @skill.name = nil
    assert !@skill.valid?
    assert @skill.errors.invalid?(:name)
  end

  test "invalid skill with missing level" do
    @skill.level = nil
    assert !@skill.valid?
    assert @skill.errors.invalid?(:level)
  end

  test "invalid skill with missing description" do
    @skill.description = nil
    assert !@skill.valid?
    assert @skill.errors.invalid?(:description)
  end

  test "invalid skill with same name for person" do
    taken = Skill.make :person => @person
    @skill.name = taken.name
    assert !@skill.valid?
    assert @skill.errors.invalid?(:name)
  end

  test "skill acts as list for person" do
    assert @skill.save
    @person.reload
    assert @person.skills[0].first?
    assert @person.skills[0].last?
  end
end
