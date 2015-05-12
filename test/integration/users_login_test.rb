require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

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
end
