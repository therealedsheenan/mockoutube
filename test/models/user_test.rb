require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should trigger email validation" do
    assert_not User.new(email: "INVALID_EMAIL", password: "password").save
  end

  test "should save the new user" do
    assert User.new(email: "user@test.com", password: "password").save
  end

  test "should trigger incorrect password confirmation validation" do
    assert_not User.new(email: "user@test.com", password: "password", password_confirmation: "pass").save
  end

  test "should trigger password validation that does not satisfy the minimum length" do
    assert_not User.new(email: "user@test.com", password: "pass").save
  end

  test "should trigger username validation" do
    user = users(:user1)

    user.username = 'test'
    assert_not user.save
  end

  test "should successfully change the username" do
    user = users(:user1)

    user.username = 'new_username'
    assert user.save
  end

  test "should save the new user with correct password confirmation" do
    assert User.new(email: "user@test.com", password: "password", password_confirmation: "password").save
  end

  test "should save the email prefix as the default username" do
    new_user = User.new(email: "user@test.com", password: "password", password_confirmation: "password")
    new_user.save

    assert_equal new_user.username, "user"
  end

  test "should not generate a password reset token if not asked to" do
    user = users(:user1)

    assert_not user.reset_password_token
    assert_not user.reset_password_sent_at
  end

  test "should not reset password if not asked to" do
    user = users(:user1)

    assert_not user.reset_password_token
    assert_not user.reset_password_sent_at
  end

  test "should generate a password reset token" do
    user = users(:user1)

    user.generate_password_token!

    assert user.reset_password_token
    assert user.reset_password_sent_at
  end
end
