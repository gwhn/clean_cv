require 'test_helper'

class SkillsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  setup :make_person

  test "should get index" do
    get :index,
        :person_id => @person.to_param
    assert_response :success
    assert_not_nil assigns(:skills)
    assert_template :index
  end

  test "should get new" do
    get :new,
        :person_id => @person.to_param
    assert_response :success
    assert_not_nil assigns(:skill)
    assert_template :new
  end

  test "new form has expected form fields" do
    assert false
  end

  test "should create skill" do
    assert_difference('Skill.count') do
      post :create,
           :person_id => @person.to_param,
           :skill => Skill.plan(:person => @person)
    end

    assert_redirected_to person_skill_path(assigns(:person),
                                           assigns(:skill))
  end

  test "should not create skill" do
    assert_no_difference('Skill.count') do
      post :create,
           :person_id => @person.to_param,
           :skill => Skill.plan(:person => @person,
                                :name => nil)
    end
    assert_not_nil assigns(:skill)
    assert_template :new
  end

  test "should create skill on xhr" do
    assert_difference('Skill.count') do
      xhr :post,
          :create,
          :person_id => @person.to_param,
          :skill => Skill.plan(:person => @person)
    end
    assert_not_nil assigns(:person)
    assert_not_nil assigns(:skill)
    assert_template :create
  end

  test "should not create skill on xhr" do
    assert_no_difference('Skill.count') do
      xhr :post,
          :create,
          :person_id => @person.to_param,
          :skill => Skill.plan(:person => @person,
                               :name => nil)
    end
    assert_not_nil assigns(:skill)
    assert_template :invalid
  end

  test "should associate current person with new skill" do
    assert false
  end

  test "should show skill" do
    get :show,
        :person_id => @person.to_param,
        :id => Skill.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:skill)
    assert_template :show
  end

  test "should get edit" do
    get :edit,
        :person_id => @person.to_param,
        :id => Skill.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:skill)
    assert_template :edit
  end

  test "edit form has expected form fields" do
    assert false
  end

  test "should update skill" do
    put :update,
        :person_id => @person.to_param,
        :id => Skill.make(:person => @person),
        :skill => Skill.plan(:person => @person)

    assert_redirected_to person_skill_path(assigns(:person),
                                           assigns(:skill))
  end

  test "should not update skill" do
    skill = Skill.make(:person => @person)
    put :update,
        :person_id => @person.to_param,
        :id => skill.to_param,
        :skill => Skill.plan(:person => @person,
                             :name => nil)
    assert_not_nil assigns(:skill)
    assert_template :edit
  end

  test "should update skill on xhr" do
    xhr :put,
        :update,
        :person_id => @person.to_param,
        :id => Skill.make(:person => @person),
        :skill => Skill.plan(:person => @person)
    assert_not_nil assigns(:person)
    assert_not_nil assigns(:skill)
    assert_template :update
  end

  test "should not update skill on xhr" do
    skill = Skill.make(:person => @person)
    xhr :put,
        :update,
        :person_id => @person.to_param,
        :id => skill.to_param,
        :skill => Skill.plan(:person => @person,
                             :name => nil)
    assert_not_nil assigns(:skill)
    assert_template :invalid
  end

  test "should get delete confirmation" do
    get :delete,
        :person_id => @person.to_param,
        :id => Skill.make(:person => @person).to_param
    assert_response :success
    assert_not_nil assigns(:skill)
    assert_template :delete
  end

  test "should destroy skill" do
    skill = Skill.make(:person => @person)
    assert_difference('Skill.count', -1) do
      delete :destroy,
             :person_id => @person.to_param,
             :id => skill.to_param
    end

    assert_redirected_to person_skills_path(assigns(:person))
  end

  test "should destroy skill on xhr" do
    skill = Skill.make(:person => @person)
    assert_difference('Skill.count', -1) do
      xhr :delete,
          :destroy,
          :person_id => @person.to_param,
          :id => skill.to_param
    end
    assert_not_nil assigns(:person)
    assert_template :destroy
  end

  test "should cancel destroy skill" do
    skill = Skill.make(:person => @person)
    assert_no_difference('Skill.count') do
      delete :destroy,
             :person_id => @person.to_param,
             :id => skill.to_param,
             :cancel => 'please'
    end

    assert_redirected_to person_skill_path(assigns(:person),
                                           assigns(:skill))
  end

  test "should reposition skills" do
    assert false
  end
end
