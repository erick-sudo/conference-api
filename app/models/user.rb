class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true
    validates :username, uniqueness: { case_sensitive: false }, presence: true
    validates :email, uniqueness: { case_sensitive: false }, presence: true
    validates :password, length: { minimum: 8 }, if: :password_required?

    def password_required?
    # check if the password is being set for the first time, or if it is being changed
    new_record? || !password.nil?
    end
end
