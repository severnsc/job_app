require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Test", last_name: "User", email: "user2@example.com", password: "Password", password_confirmation: "Password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should have a first name" do
    @user.first_name = " "
    assert_not @user.valid?
  end

  test "should have a last name" do
    @user.last_name = " "
    assert_not @user.valid?
  end

  test "should have an email" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "email should be valid" do
    invlaid_emails = %w[user@examplecom useratexample.com user@exampledotcom user@example.com.]
    invlaid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email} should not be valid"
    end
  end

  test "user should have a password" do
    @user.password = " "
    assert_not @user.valid?
  end

  test "user password should be 6 long minimum" do
    @user.password = "a"*5
    assert_not @user.valid?
  end

  test "user password and confimration should match" do
    @user.password_confirmation = "passowrd"
    assert_not @user.valid?
  end
end
