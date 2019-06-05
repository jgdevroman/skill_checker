require 'test_helper'

class UserSkillsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user_skill = user_skills(:sleep)
    @other_user = users(:two)
    @other_user_skill = user_skills(:eat)
  end

  test "should redirect create when not logged in" do
    assert_no_difference "UserSkill.count" do
      post user_skills_path, params: {user_skill: {name: "Cool Skill"}}
    end
    assert_redirected_to login_path
  end
  
  test "should redirect destroy when not logged in" do
    # @user.user_skills.create!(name: @user_skill.name)
    assert_no_difference "UserSkill.count" do
      delete user_skill_path(@user_skill)
    end
    assert_redirected_to login_path
  end

  test "should redirect destroy on wrong user_skill" do
    log_in_as(@user)
    assert_no_difference "UserSkill.count" do
      delete user_skill_path(@other_user_skill)
    end
    assert_redirected_to root_path
  end

  test "should create skill for a user when logged in" do
    log_in_as(@user)
    assert_difference "UserSkill.count" do
      post user_skills_path, params: {user_skill: {name: "Cool Skill" , user_id: @user.id}}
    end
    assert_redirected_to user_path(@user)
    assert_not flash.empty?

    assert @user.user_skills.find_by(name: "Cool Skill")
    assert_difference "UserSkill.count" do
      post user_skills_path, params: {user_skill: {name: "Cool Skill" , user_id: @other_user.id}}
    end
    assert_redirected_to user_path(@other_user)
    assert flash.any?
  end

  test "sould not create skill when name empty or too long" do
    log_in_as(@user)
    assert_no_difference "UserSkill.count" do
      post user_skills_path, params: {user_skill: {name: "" , user_id: @user.id}}
    end
    assert_no_difference "UserSkill.count" do
      post user_skills_path, params: {user_skill: {name: "a"*51 , user_id: @user.id}}
    end
  end
  
end
