
	class User < ApplicationRecord
	require 'bcrypt'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  #belongs_to :meta, polymorphic: true
	has_one :picture, as: :imageable,dependent: :destroy

	validates :email, uniqueness: true, presence: true
	validates :password, presence: true,:on => :create
	#validates :password,length: { minimum: 8 }

	has_many :user_taggings,dependent: :destroy
	has_many :tags, through: :user_taggings
	#validates_confirmation_of :password
	#validates_presence_of :password_confirmation
  def valid_password?(password)
  	return false if encrypted_password.blank?
  	# Given an encrypted password it will return a valid hash
  	bcrypt   = ::BCrypt::Password.new(encrypted_password)
  	if self.class.pepper.present?
      password = "#{password}#{self.class.pepper}"
    end
    #Given a valid salt and a secret it will return hash
    password = ::BCrypt::Engine.hash_secret(password, bcrypt.salt)
    Devise.secure_compare(password, encrypted_password)
  end

  def generate_auth_token
  	token = Devise.friendly_token()
  	self.update_columns(auth_token: token,auth_token_created_at: Time.zone.now)
  	token
  end

  def invalidate_auth_token
  	self.update_columns(auth_token: nil,auth_token_created_at: nil)
  end

  def set_reset_password_token
    raw_token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
    self.update_columns(reset_password_token: hashed_token,reset_password_sent_at: Time.now)
    hashed_token
  end
end
