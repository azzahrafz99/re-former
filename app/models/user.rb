class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  validates :username, presence:true
  validates :email, presence:true
  validates :password, presence:true
  validates :password_confirmation, presence:true

  has_secure_password


  def self.digest(string)
    # BCrypt::Password.create(Digest::SHA1.hexdigest(token)).to_s
    # cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    #                                               BCrypt::Engine.cost
    
    BCrypt::Password.create(string)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    # self.remember_digest = User.digest(remember_token)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
