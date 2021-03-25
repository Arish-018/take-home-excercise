# frozen_string_literal: true

# models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def friendly_password
    password_length = 6
    Devise.friendly_token.first(password_length)
  end
end
