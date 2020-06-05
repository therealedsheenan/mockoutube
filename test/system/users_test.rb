require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup { @user = users(:user1) }

  test 'should show validation errors on user creation' do
    visit new_user_url

    fill_in :user_email, with: ''
    fill_in :user_password, with: ''
    fill_in :user_password_confirmation, with: ''
    click_on 'Create User'

    assert_text 'Something went wrong!'
  end

  test 'should successfully create a new user' do
    visit new_user_url

    fill_in :user_email, with: 'new@user.com'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_on 'Create User'

    assert_text 'User was successfully created'
  end

  test 'should be redirected to login page if not logged-in' do
    visit user_url(@user)

    assert_text 'Login'
  end

  test 'should be able to visit the user profile if logged-in' do
    visit login_url

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'

    click_on 'Login'

    visit user_url(@user)
    assert_text 'User Information'
    assert_text @user.email
    assert_text @user.username
  end

  test 'should not be able to update user on text inputs' do
    visit login_url

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'

    click_on 'Login'

    visit edit_user_url(@user)

    fill_in :user_username, with: 'xxx'
    fill_in :user_password, with: 'match'
    fill_in :user_password_confirmation, with: 'unmatched'
    click_on 'Update User'

    assert_text 'Something went wrong!'
    assert_text 'Username is too short'
    assert_text 'Password confirmation doesn\'t match Password'
    assert_text 'Password is too short'
  end

  test 'should be able to successfully update user on valid text inputs' do
    visit login_url

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'

    click_on 'Login'

    visit edit_user_url(@user)

    fill_in :user_username, with: 'new_username'
    fill_in :user_password, with: 'new_password'
    fill_in :user_password_confirmation, with: 'new_password'
    click_on 'Update User'

    assert_text 'User was successfully updated.'
  end
end
