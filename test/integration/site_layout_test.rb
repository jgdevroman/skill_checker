require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:one)
  end

  test "layout links" do 
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 3
    assert_select 'a[href=?]', about_path, count: 2
    assert_select 'a[href=?]', "https://romanshirasaki.com"
    assert_select 'a[href=?]', signup_path
    get about_path
    assert_select "title", full_title("About")
    get signup_path
    assert_select "title", full_title("Sign up")

    get users_path
    log_in_as(@user)
    assert_redirected_to users_path
    follow_redirect!
    assert_template 'users/index'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', about_path, count: 1
    assert_select 'a[href=?]', users_path, count: 1
    # assert_select 'a[href=?]', user_path(@user), count: 2
    assert_select 'a[href=?]', edit_user_path(@user), count: 1
    assert_select 'a[href=?]', logout_path, count: 1


  end
    
end
