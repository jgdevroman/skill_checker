require 'test_helper'

class UserSkillsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "UserSkills interface" do
    log_in_as(@user)
    get user_path(@user)
    assert_select "form"
    #invalid submission
    assert_no_difference "UserSkill.count" do
      post user_skills_path, params: {user_skill: { name: "", user_id: @user.id}}
    end
    assert_select "div#error-messages"

    #valid submission
    assert_difference "UserSkill.count", 1 do
      post user_skills_path, params: {user_skill: { name: "sleep", user_id: @user.id}}
    end
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_select 'a.delete-link'

    #delete post
    assert_difference "UserSkill.count", -1 do
      delete user_skill_path(@user.user_skills.first)
    end
    
    #no delete link in other users
    get user_path(users(:two))
    assert_select 'a.delete-link', count: 0

  end
end
