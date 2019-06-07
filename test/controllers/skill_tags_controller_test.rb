require 'test_helper'

class SkillTagsControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @one = users(:one)
    @two = users(:two)
    @sleeping = skill_tags(:sleeping)
    @eating = skill_tags(:eating)
    @skill_sleep = user_skills(:sleep)
    @skill_eat = user_skills(:eat)
  end

  test "should show skill tag" do
    get skill_tag_path(@sleeping)
    assert_response :success
    log_in_as(@one)
    get skill_tag_path(@sleeping)
    assert_response :success
  end

  test "should redirect to same tag after endorsement or skill add" do
    log_in_as(@one)
    get skill_tag_path(@eating)
    post endorsements_path, params: {user_skill_id: @skill_eat.id}
    assert flash.any?
    assert_redirected_to skill_tag_path(@eating)
    follow_redirect!
    post user_skills_path, params: {user_skill: {user_id: @one.id, name: @skill_eat.name}}
    assert flash.any?
    assert_redirected_to skill_tag_path(@eating)
  end

  test "shoud make new skill_tag for new user_skill" do
    log_in_as(@one)
    assert_difference "SkillTag.count", 1 do
      post user_skills_path, params: {user_skill: {user_id: @one.id, name: "New Skill"}}
    end
    log_in_as(@two)
    assert_no_difference "SkillTag.count" do
      post user_skills_path, params: {user_skill: {user_id: @two.id, name: "New Skill"}}
    end
  end

end
