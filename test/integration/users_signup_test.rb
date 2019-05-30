require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do 
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference "User.count" do 
        post signup_path params: 
        {user: {
            name: "",
            email: "email@email",
            password: "foo",
            password_confirmation: "bar" 
        }}
    end
    assert_template 'users/new'
    assert_select 'div#error-messages'
    assert_select 'div.field_with_errors'

  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post signup_path params: 
        {user: {
            name: "Foo Bar",
            email: "foo@email.com",
            password: "1234567890",
            password_confirmation: "1234567890" 
        }}
      end
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
  end

end
