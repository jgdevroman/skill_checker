require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Skill Checker"
    assert_equal full_title("About"), "About | Skill Checker"
    assert_equal full_title("Sign up"), "Sign up | Skill Checker"
  end
end