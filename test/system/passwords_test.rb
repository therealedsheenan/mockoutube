require 'application_system_test_case'

class PasswordsTest < ApplicationSystemTestCase
  setup { @user = users(:user1) }

  test 'should visit the forgot password page' do
    visit password_forgot_url

    assert_text 'Forgot password'
  end

  test 'should not be able to receive an email if the inputted email is not valid' do
    visit password_forgot_url

    fill_in :email, with: "invalid_email"
    click_on 'Reset password'

    assert_text 'Email should be valid.'
  end

  test 'should not be able to receive an email using a valid input email' do
    visit password_forgot_url

    fill_in :email, with: @user.email
    click_on 'Reset password'

    assert_text 'An email would be sent to you containing information on how to reset your password.'
  end

  test 'should not be able to visit password reset form with an invalid reset token' do
    visit password_reset_url

    assert_text 'Forgot password'
  end

  test 'should be able to visit the password reset form using a valid reset token' do
    visit password_forgot_url

    fill_in :email, with: @user.email
    click_on 'Reset password'

    user = User.find_by(email: @user.email)

    visit password_reset_url + "?token=#{user.reset_password_token}"

    assert_text 'Reset Password'
  end

  test 'should be able to reset password successfully' do
    visit password_forget_url

    fill_in :email, with: @user.email
    click_on 'Reset password'

    user = User.find_by(email: @user.email)

    visit password_reset_url + "?token=#{user.reset_password_token}"

    fill_in :password, with: 'new_password'
    fill_in :password_confirmation, with: 'new_password'

    click_on 'Reset password'

    assert_text 'Password successfully reset. You can now login using your new password.'

    fill_in :email, with: @user.email
    fill_in :password, with: 'new_password'

    click_on 'Login'

    assert_text 'You have successfully logged-in!'
  end

end
