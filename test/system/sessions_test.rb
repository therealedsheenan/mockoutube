require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  setup { @user = users(:user1) }

  test 'should visit login' do
    visit login_url

    assert_text 'Login'
  end

  test 'should not be able to login on invalid credentials' do
    visit login_url

    fill_in :email, with: ''
    fill_in :password, with: ''
    click_on 'Login'

    assert_text 'Email or password is invalid'
  end

  test 'should be able to login with valid credentials' do
    visit login_url

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'
    click_on 'Login'

    assert_text 'You have successfully logged-in!'
  end

  test 'should be able to logout' do
    visit login_url

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'
    click_on 'Login'

    visit logout_url
    assert_text 'You have successfully logged-out!'
  end
end
