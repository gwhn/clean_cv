require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  setup :activate_authlogic
  setup :plan_person

  def plan_person
    @session = login_as users(:guy)
    plan = Person.plan
    @person = Person.new :name => plan[:name],
                         :job_title => plan[:job_title],
                         :email => plan[:email],
                         :phone => plan[:phone],
                         :mobile => plan[:mobile],
                         :profile => plan[:profile],
                         :photo => plan[:photo],
                         :user => @session.user
  end

  test "valid person" do
    assert_difference('Person.count') do
      assert @person.valid?
      assert @person.save
    end
  end

  test "invalid person with missing name" do
    @person.name = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:name)
  end

  test "invalid person with missing job_title" do
    @person.job_title = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:job_title)
  end

  test "invalid person with missing email" do
    @person.email = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:email)
  end

  test "invalid person with missing phone" do
    @person.phone = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:phone)
  end

  test "invalid person with missing mobile" do
    @person.mobile = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:mobile)
  end

  test "invalid person with missing profile" do
    @person.profile = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:profile)
  end

  test "invalid person with missing photo" do
    @person.photo_file_name = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:photo_file_name)
  end

  test "invalid person with missing user" do
    @person.user = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:user)
  end

  test "invalid person with taken name" do
    @person.name = Person.make(:user => @session.user).name
    assert !@person.valid?
    assert @person.errors.invalid?(:name)
  end

  test "invalid person with taken email" do
    @person.email = Person.make(:user => @session.user).email
    assert !@person.valid?
    assert @person.errors.invalid?(:email)
  end

  test "invalid person with wrong format url" do
    ['this is not a valid url', 'nor.is.this', 'or_this'].each do |url|
      @person.flickr_url = @person.twitter_url = @person.facebook_url = @person.linked_in_url = url
      assert !@person.valid?
      assert @person.errors.invalid?(:flickr_url)
      assert @person.errors.invalid?(:twitter_url)
      assert @person.errors.invalid?(:facebook_url)
      assert @person.errors.invalid?(:linked_in_url)
    end
  end

  test "invalid person with wrong format email" do
    ['wrong_email', 'wrong.email', 'wrong_email@', 'wrong@email'].each do |email|
      @person.email = email
      assert !@person.valid?
      assert @person.errors.invalid?(:email)
    end
  end

  test "associated companies ordered by start date" do
    assert false
  end

  test "associated skills ordered by list position" do
    assert false
  end

  test "associated schools ordered by date from" do
    assert false
  end

  test "accepts photo file upload" do
    assert false
  end

  test "small style photo created on photo file upload" do
    assert false
  end

  test "rejects photo file upload more than 10mb" do
    assert false
  end

  test "rejects photo file upload unless an image" do
    assert false
  end
end
