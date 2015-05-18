require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @user               = users(:michael)
    @user_not_activated = users(:greg)
  end

  test "show not activated user" do
    log_in_as(@user)
    get user_path(@user_not_activated)
    assert_redirected_to root_url
  end
end
