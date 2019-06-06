require 'test_helper'

class EndorseTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @uskill = user_skills(:sleep)
    @other_uskill = user_skills(:eat)
    @three = users(:three)
    # @endo = Endorsement.new()
  end
  
  test "test endorse interface" do
    #no endorsing if not logged in
    get user_path(@user)
    assert_select "endorse", count: 0
    assert_select "a.delete-link", count: 0
    assert_select "button.invisible-button", count: 0
    

    #no endorsing if same user
    log_in_as(@user)
    get user_path(@user)
    assert_select "div.skill-item"
    assert_select "endorse", count: 0
    #endorsed by other user
    @other_user.endorse(@uskill)
    get user_path(@user)
    assert_select "a[href=?]", user_path(@other_user)
    
    #endorse other users skill
    get user_path(@other_user)
    assert_select "div.plus", count: 1
    assert_select "input.invisible-button", count: 1
    assert_difference "Endorsement.count" do
      post endorsements_path, params: {user_skill_id: @other_uskill.id}
    end
    follow_redirect!
    assert_select "div.plus", count: 0
    assert_select "input.invisible-button", count: 0
    assert_select "div.disabled"
    assert_select "a[href=?]", user_path(@user)
    
    #shouldn't endorse same skill
    assert_no_difference "Endorsement.count" do
      post endorsements_path, params: {user_skill_id: @other_uskill.id}
    end
    #endorse when new skill added
    assert_difference "Endorsement.count" do
      post user_skills_path, params: {user_skill: { name: "breathe", user_id: @other_user.id}}
    end

    #link to endorsers
    @three.endorse(@other_user.user_skills.find_by(name: "breathe"))
    get user_path(@other_user)
    assert_select "a[href=?]", user_path(@three)
    assert_select "a[href=?]", user_path(@user)
    
    #most endorsed should be on top
    assert_equal @other_user.user_skills.first.endorsements_count, 2

    #endorsement decrements after user deletion
    assert_difference "Endorsement.count", -1 do
      @three.destroy
    end
    assert_equal @other_user.user_skills.first.endorsements_count, 1
    
  end
end 
