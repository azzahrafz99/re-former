class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :username, presence:true
  validates :email, presence:true
  validates :password, presence:true
  validates :password_confirmation, presence:true

  has_secure_password

  attr_accessor :remember_token

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
