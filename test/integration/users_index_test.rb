require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @non_admin = users(:two)
  end


  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'nav.pagination', count: 2
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text=user.name
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end

  end
  
end
