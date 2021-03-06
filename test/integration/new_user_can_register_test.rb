require "test_helper"

class NewUserCanRegisterTest < ActionDispatch::IntegrationTest
  test "new user can register and be logged in" do
    visit root_path
    click_on "Login"
    click_on "Create Account"
    fill_in "Username", with: "Dan"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create Account"
    user = User.last

    refute user.admin?
    assert_equal dashboard_path, current_path
    assert page.has_content?("Logged In As: #{user.username}")
  end

  test "error is provided if no username is provided" do
    visit new_user_path
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create Account"

    assert page.has_content?("Username can't be blank")
  end
end
