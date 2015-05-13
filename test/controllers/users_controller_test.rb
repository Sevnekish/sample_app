require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
    @user = users(:michael)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign up | #{@base_title}"
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user # id: @user automatically uses @user.id.
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
