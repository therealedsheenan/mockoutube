require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get login_url

    assert_response :success
  end

  test 'should redirect to the login path if credentials are invalid' do
    post sessions_url, params: { email: 'invalid', password: 'invalid' }

    assert_equal 'Email or password is invalid', flash[:alert]
    assert_redirected_to login_path
  end

  test 'should redirect to the logged-in user\'s page using valid credentials' do
    user = users(:user1)
    login_user(user)

    assert_equal 'You have successfully logged-in!', flash[:notice]
    assert_redirected_to user_path(user)
  end

  test 'should successfully logout a logged-in user' do
    user = users(:user1)
    login_user(user)
    logout_user(user)

    assert_equal 'You have successfully logged-out!', flash[:notice]
    assert_redirected_to new_session_path
  end
end
