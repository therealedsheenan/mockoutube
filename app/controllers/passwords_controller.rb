class PasswordsController < ApplicationController
  def index
  end

  def new_password
    if params[:token].blank?
      redirect_to password_forgot_path if params[:token].blank?
    else
      @user = User.find_by(reset_password_token: params[:token])

      if @user.present?
        redirect_to password_forgot_path unless @user.password_token_valid?
      else
        redirect_to password_forgot_path
      end
    end
  end

  def forgot
    email = params[:email]
    user = User.find_by(email: email.downcase)

    if user.present?
      user.generate_password_token!
      url = "#{password_reset_url}?token=#{user.reset_password_token}"
      UserMailer.forgot_password(user, url).deliver_now

      redirect_to password_forgot_path, notice: 'An email would be sent to you containing information on how to reset your password.'
    else
      redirect_to password_forgot_path, alert: 'Email should be valid.'
    end
  end

  def reset
    user = User.find_by(reset_password_token: params[:token].to_s)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        redirect_to login_path, notice: 'Password successfully reset. You can now login using your new password.'
      else
        flash.now[:alert] = 'Something went wrong.'
        render 'new_password'
      end
    else
      flash.now[:alert] = 'Link not valid or expired. Try generating a new link.'
      render 'new_password'
    end
  end
end
