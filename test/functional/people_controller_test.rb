require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup :activate_authlogic

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
    assert_template :index
  end

  test "should get index by name in ascending order" do
    assert false
  end

  test "should get index by email in descending order" do
    assert false
  end

  test "should get page of index" do
    assert false
  end

  test "should get new" do
    login_as users(:guy)
    get :new
    assert_response :success
    assert_not_nil assigns(:person)
    assert_template :new
  end

  test "new form has expected form fields" do
    login_as users(:guy)
    get :new
    assert_select 'form[id=new_person][action=?]', people_path(:format => :js) do
      assert_select 'input[type=text][id=person_name][name=?]', 'person[name]'
      assert_select 'input[type=text][id=person_job_title][name=?]', 'person[job_title]'
      assert_select 'input[type=text][id=person_email][name=?]', 'person[email]'
      assert_select 'input[type=text][id=person_phone][name=?]', 'person[phone]'
      assert_select 'input[type=text][id=person_mobile][name=?]', 'person[mobile]'
      assert_select 'input[type=file][id=person_photo][name=?]', 'person[photo]'
      assert_select 'input[type=text][id=person_flickr_url][name=?]', 'person[flickr_url]'
      assert_select 'input[type=text][id=person_twitter_url][name=?]', 'person[twitter_url]'
      assert_select 'input[type=text][id=person_facebook_url][name=?]', 'person[facebook_url]'
      assert_select 'input[type=text][id=person_linked_in_url][name=?]', 'person[linked_in_url]'
      assert_select 'textarea[id=person_profile][name=?]', 'person[profile]'
    end
  end

  test "should create person" do
    login_as users(:guy)
    assert_difference('Person.count') do
      post :create, :person => Person.plan
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test "should not create person" do
    login_as users(:guy)
    assert_no_difference('Person.count') do
      post :create,
           :person => Person.plan(:name => nil)
    end
    assert_not_nil assigns(:person)
    assert_template :new
  end

  test "should create person on xhr" do
    login_as users(:guy)
    assert_difference('Person.count') do
      xhr :post, :create, :person => Person.plan
    end
    assert_not_nil assigns(:person)
    assert_template :create
  end

  test "should not create person on xhr" do
    login_as users(:guy)
    assert_no_difference('Person.count') do
      xhr :post,
          :create,
          :person => Person.plan(:name => nil)
    end
    assert_not_nil assigns(:person)
    assert_template :invalid
  end

  test "should associate current user with new person" do
    assert false
  end

  test "should show person" do
    get :show,
        :id => people(:homer).to_param
    assert_response :success
    assert_not_nil assigns(:person)
    assert_template :show
  end

  test "should get edit" do
    login_as users(:guy)
    get :edit,
        :id => people(:homer).to_param
    assert_response :success
    assert_not_nil assigns(:person)
    assert_template :edit
  end

  test "edit form has expected form fields" do
    assert false
  end

  test "should update person" do
    session = login_as users(:guy)
    person = Person.make(:user => session.user)
    put :update,
        :id => person.to_param,
        :person => Person.plan

    assert_redirected_to person_path(assigns(:person))
  end

  test "should not update person" do
    session = login_as users(:guy)
    person = Person.make(:user => session.user)
    put :update,
        :id => person.to_param,
        :person => Person.plan(:name => nil)
    assert_not_nil assigns(:person)
    assert_template :edit
  end

  test "should update person on xhr" do
    session = login_as users(:guy)
    person = Person.make(:user => session.user)
    xhr :put,
        :update,
        :id => person.to_param,
        :person => Person.plan
    assert_not_nil assigns(:person)
    assert_template :update
  end

  test "should not update person on xhr" do
    flunk
#    session = login_as users(:guy)
#    person = Person.make(:user => session.user)
#    xhr :put,
#        :update,
#        :id => person.to_param,
#        :person => Person.plan(:name => nil)
#    assert_not_nil assigns(:person)
#    assert_template :invalid
  end

  test "should get delete confirmation" do
    login_as users(:guy)
    get :delete,
        :id => people(:homer).to_param
    assert_response :success
    assert_not_nil assigns(:person)
    assert_template :delete
  end

  test "should destroy person" do
    login_as users(:guy)
    assert_difference('Person.count', -1) do
      delete :destroy,
             :id => people(:marge).to_param
    end

    assert_redirected_to people_path
  end

  test "should destroy person on xhr" do
    login_as users(:guy)
    assert_difference('Person.count', -1) do
      xhr :delete,
          :destroy,
          :id => people(:marge).to_param
    end
    assert_template :redirect
  end

  test "should cancel destroy person" do
    login_as users(:guy)
    assert_no_difference('Person.count') do
      delete :destroy,
             :id => people(:homer).to_param,
             :cancel => 'please'
    end

    assert_redirected_to person_path(assigns(:person))
  end
end
