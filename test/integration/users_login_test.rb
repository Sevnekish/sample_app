require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    # Visit the login path
    get login_path
    # Verify that the new sessions form renders properly
    assert_template 'sessions/new'
    # Post to the sessions path with an invalid params hash
    post login_path, session: { email: "", password: ""}
    # Verify that the new sessions form gets re-rendered and that a flash message appears.
    assert_template 'sessions/new'
    assert_not flash.empty?
    # Visit another page
    get root_path
    # Verify that the flash message doesn’t appear on the new page
    assert flash.empty?
  end

  test "login with valid inforamtion followed by logout" do
    # Visit the login path
    get login_path
    # Post valid information to the sessions path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    # Check the right redirect target
    assert_redirected_to @user
    # Actually visit the target page
    follow_redirect!
    assert_template 'users/show'
    # Verify that the login link disappears
    assert_select "a[href=?]", login_path, count: 0
    # Verify that a logout link appears
    assert_select "a[href=?]", logout_path
    # Verify that a profile link appears
    assert_select "a[href=?]", user_path(@user)

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url

    #Simulate a user clicking logout in a second window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
      log_in_as(@user, remember_me: '1')
      # Inside tests the cookies method doesn’t work with symbols as keys
      # cookies[:remember_token] is always nil
      # Cookies does work with string keys:
      assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
      log_in_as(@user, remember_me: '0')
      assert_nil cookies['remember_token']
  end
end
