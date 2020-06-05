require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'should send a welcome email' do
    user = users(:user1)
    welcome_email = UserMailer.welcome(user)

    assert_emails 1 do
      welcome_email.deliver_now
    end

    assert_equal ['no-reply@company.com'], welcome_email.from
    assert_equal [user.email], welcome_email.to
    assert_equal 'Welcome to our App!', welcome_email.subject
  end

  test 'should send the forgot password information with a reset token' do
    user = users(:user1)
    user.generate_password_token!
    example_url = 'http://example.com?token=xxxxx'

    forgot_pass_email = UserMailer.forgot_password(user, example_url)

    assert_emails 1 do
      forgot_pass_email.deliver_now
    end

    assert_equal ['no-reply@company.com'], forgot_pass_email.from
    assert_equal [user.email], forgot_pass_email.to
    assert_equal 'Forgot your password?', forgot_pass_email.subject
    assert_match example_url, forgot_pass_email.body.to_s
  end
end
