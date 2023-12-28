class User < ApplicationRecord
    has_many :tweets
    has_many :twitter_accounts
    has_secure_password
    validates :email, presence: true
    validates :password, presence: true
    validates :password_confirmation, presence: true
end
