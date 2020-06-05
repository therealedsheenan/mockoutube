class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, confirmation: true, unless: -> { password.blank? }
  validates :username, length: { minimum: 5 }, on: :update, unless: -> { username.blank? }

  before_create :assign_default_username

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now
    self.save!(validate: false)
  end

  def password_token_valid?
    (self.reset_password_sent_at + 6.hours) > Time.now
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password

    self.save!
  end

  private

  def assign_default_username
    self.username = self.email.split('@')[0]
  end

  def generate_token
    SecureRandom.hex(10)
  end
end
