# frozen_string_literal: true

# models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  scope :all_non_admin_users, -> { where.not role: 'admin' }

  after_initialize :set_default_role, if: :new_record?
  after_create :send_reset_password_instructions
  enum role: %I[admin user]

  def friendly_password
    password_length = 6
    Devise.friendly_token.first(password_length)
  end

  def set_default_role
    self.role ||= 1
  end
end
