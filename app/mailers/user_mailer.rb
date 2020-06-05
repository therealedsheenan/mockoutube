class UserMailer < ApplicationMailer
  default from: 'no-reply@company.com'

  def welcome(user)
    @user = user
    mail(to: "#{user.email}", subject: 'Welcome to our App!')
  end

  def forgot_password(user, url)
    @user = user
    @url = url

    mail(to: "#{user.email}", subject: 'Forgot your password?')
  end
end
