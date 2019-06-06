require 'test_helper'

class EndorsementsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @uskill = user_skills(:sleep)
    @other_user = users(:two)
    @other_uskill = user_skills(:eat)
  end

  test "create should require login" do
    assert_no_difference "Endorsement.count" do
      post endorsements_path
    end
    assert_redirected_to login_path
  end

  test "shouldn't endorse own skill" do
    log_in_as(@user)
    assert_no_difference "Endorsement.count" do
      post endorsements_path, params: {user_skill_id: @uskill.id}
    end
    assert_redirected_to root_url
  end

  test "should endorse other users skill" do
    log_in_as(@user)
    assert_difference "Endorsement.count" do
      post endorsements_path, params: {user_skill_id: @other_uskill.id}
    end

  end

end
