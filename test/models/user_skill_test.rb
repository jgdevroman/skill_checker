require 'test_helper'

class UserSkillTest < ActiveSupport::TestCase
  def setup
    @name = "Cool Skill"
    @user = users(:one)
    @other_user = users(:two)
    @uskill = @user.user_skills.build(name: @name)
  end

  test "should be valid" do
    assert @uskill.valid?
  end

  test "user id should be present" do
    @uskill.user_id = nil
    assert_not @uskill.valid?
  end

  test "name should be present" do
    @uskill.name = nil
    assert_not @uskill.valid?
  end

  test "name should be unique for one user but can be case insensitive" do
    duplicate_uskill = @uskill.dup
    @uskill.save
    assert_not duplicate_uskill.valid?
    
    duplicate_uskill.name = @uskill.name.upcase
    assert duplicate_uskill.valid?
  end

  test "same names should be valid on different users" do
    @uskill.save
    other_uskill = @other_user.user_skills.build(name: @name)
    other_uskill.save
    assert other_uskill.valid?
  end

  test "names shouldn't be longer than 50 characters" do
    @uskill.name = "a"*51
    assert_not @uskill.valid?
  end


end
