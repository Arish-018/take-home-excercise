# frozen_string_literal: true

# models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_initialize :set_default_role, if: :new_record?
  enum role: %I[admin user]

  def friendly_password
    password_length = 6
    Devise.friendly_token.first(password_length)
  end

  def set_default_role
    self.role ||= 1
  end
end
