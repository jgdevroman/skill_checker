require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
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
  end
    
end
