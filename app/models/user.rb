class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i(google facebook twitter)

  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.new(email: auth.info.email,
                      provider: auth.provider,
                      uid:      auth.uid,
                      password: Devise.friendly_token[0, 20])
    end

    user.save
    user
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(provider: auth.provider,
                      uid:      auth.uid,
                      email:    "#{auth.uid}-#{auth.provider}@example.com",
                      password: Devise.friendly_token[0, 20])
    end

    user.save
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(provider: auth.provider,
                      uid:      auth.uid,
                      email:    "#{auth.uid}-#{auth.provider}@example.com",
                      password: Devise.friendly_token[0, 20])
    end

    user.save
    user
  end

  def create_unique_string
    SecureRandom.uuid
  end
end
