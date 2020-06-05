require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup { @user = users(:user1) }

  test 'should get new' do
    get new_user_url

    assert_response :success
  end

  test 'should not create a user on invalid credentials' do
    # Error on invalid email
    assert_no_difference('User.count') do
      post users_url,
           params: {
               user: { email: 'INVALID_EMAIL', password: 'password' }
           }
    end

    # Error on minimum password length
    assert_no_difference('User.count') do
      post users_url,
           params: {
               user: { email: 'user@test.com', password: 'pass' }
           }
    end
  end

  test 'should create user successfully using valid credentials' do
    assert_difference('User.count') do
      post users_url,
           params: {
             user: { email: 'user@test.com', password: 'password' }
           }
    end

    assert_redirected_to user_url(User.last)
  end

  test 'should get the sign-up page' do
    get signup_url

    assert_response :success
  end

  test 'should redirect to login path if not logged-in' do
    get user_url(@user)

    assert_response :redirect
  end

  test 'should show user if logged-in' do
    login_user(@user)
    get user_url(@user)

    assert_response :success
  end

  test 'should get edit' do
    login_user(@user)
    get edit_user_url(@user)

    assert_response :success
  end

  test 'should not update user on invalid credentials' do
    # Invalid username length
    assert_no_difference(@user.username) do
      patch user_url(@user),
            params: {
                user: { username: 'user' }
            }
    end

    # Invalid password length
    assert_no_difference(@user.password) do
      patch user_url(@user),
            params: {
                user: { password: 'pass' }
            }
    end
  end

  test 'should update user on valid credentials' do
    # valid username length
    assert_difference(@user.username) do
      patch user_url(@user),
            params: {
                user: { username: 'updated_username' }
            }
    end

    # valid password length
    assert_difference(@user.password) do
      patch user_url(@user),
            params: {
                user: { password: 'new_password' }
            }
    end
  end
end
