require 'test_helper'

class SkillTagInterfaceTest < ActionDispatch::IntegrationTest
  def setup 
    @one = users(:one)
    @two = users(:two)
    @sleeping = skill_tags(:sleeping)
    @eating = skill_tags(:eating)
    @skill_sleep = user_skills(:sleep)
    @skill_eat = user_skills(:eat)
  end

  test "test interface" do
    #no skill button or endorsement button if not logged in
    get skill_tag_path(@sleeping)
    assert_select "form", count: 0

    log_in_as(@one)

    #already added skill
    get skill_tag_path(@sleeping)
    assert_template "skill_tags/show"
    assert_select "input[disabled=?]", "disabled"
    assert_select "div.card", count: 1
    assert_select "div.plus", count: 0
    #two adds the skill
    two_sleep = @two.user_skills.create!(name:"Sleeping", skill_tag_id: @sleeping.id)
    get skill_tag_path(@sleeping)
    assert_select "div.card", count: 2
    assert_select "div.plus", count: 1

    #endorse skill of two
    @one.endorse(two_sleep)
    get skill_tag_path(@sleeping)
    assert_select "div.disabled", count: 1

    #see eating skill
    get skill_tag_path(@eating)
    assert_select "div.card", count: 1
    assert_select "input[data-disable-with=?]", "Add skill"
    assert_select "div.plus", count: 1
    #add skill to one
    one_eat = @one.user_skills.create!(name:"Eating", skill_tag_id: @eating.id)
    get skill_tag_path(@eating)
    assert_select "div.plus", count: 1
    assert_select "div.card", count: 2
    assert_select "input[disabled=?]", "disabled"

  end
end
