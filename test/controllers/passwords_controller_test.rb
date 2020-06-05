require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  # #index
  test 'should get reset password index page' do
    get password_forgot_url

    assert_response :success
  end

  # #new_password
  test 'should redirect if reset token is blank' do
    get password_reset_url

    assert_response :redirect
    assert_redirected_to password_forgot_path
  end

  # #new_password
  test 'should redirect if reset token is invalid' do
    get password_reset_url(token: 'INVALID')

    assert_response :redirect
    assert_redirected_to password_forgot_path
  end

  # #new_password
  test 'should get new_password on valid reset token' do
    user = users(:user1)
    user.generate_password_token!

    get password_reset_url(token: user.reset_password_token)

    assert_response :success
  end

  # #forgot
  test 'should flash error on forgot if email does not exist' do
    post password_forgot_url(email: '')

    assert_equal 'Email should be valid.', flash[:alert]
  end

  # #forgot
  test 'should successfully reset token if an email exist' do
    user = users(:user1)
    post password_forgot_url(email: user.email)

    assert_response :redirect
    assert_redirected_to password_forgot_path
  end

  # #reset
  test 'should not be able to reset password if reset token is invalid' do
    invalid_token = 'invalid-token'

    post password_reset_url(token: invalid_token)

    assert_equal 'Link not valid or expired. Try generating a new link.', flash[:alert]
  end

  # #reset
  test 'should be able to reset password successfully using a valid reset token' do
    user = users(:user1)
    user.generate_password_token!

    post password_reset_url(token: user.reset_password_token, password: 'newpassword')

    assert_redirected_to login_path
    assert_equal 'Password successfully reset. You can now login using your new password.', flash[:notice]
  end
end
