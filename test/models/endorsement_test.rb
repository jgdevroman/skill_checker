require 'test_helper'

class EndorsementTest < ActiveSupport::TestCase

  def setup
    @endorsement = Endorsement.new(endorser_id: users(:one).id, user_skill_id: user_skills(:sleep).id)
  end

  test "should be valid" do
    assert @endorsement.valid?
  end

  test "should require an endorser id" do
    @endorsement.endorser_id = nil
    assert_not @endorsement.valid?
  end

  test "should require an user_skill id" do
    @endorsement.user_skill_id = nil
    assert_not @endorsement.valid?
  end

  test "should endorse a skill by user and shouldn't endorse again" do
    user = users(:one)
    other_user_skill = user_skills(:eat)
    assert_not other_user_skill.endorsed?(user)
    user.endorse(other_user_skill)
    assert other_user_skill.endorsed?(user)

    assert_not user.endorse(other_user_skill)

  end

  test "should not endorse own skill" do
    user = users(:one)
    own_uskill = user.user_skills.first
    assert_not user.endorse(own_uskill)
  end

  test "should not endorse an empty skill" do
    user = users(:one)
    assert_not user.endorse(nil)
  end

end