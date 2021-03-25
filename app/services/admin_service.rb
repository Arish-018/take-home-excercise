# frozen_string_literal: true

# Creates Admin
class AdminService
  include AtYourService.with(strict: true)

  def call
    user = User.find_or_initialize_by(email: 'admin@techhome.com')
    user.password = 'admin1234'
    user.password_confirmation = 'admin1234'
    user.role = 0
    message(user) if user.save
  end

  def message(user)
    puts 'CREATED ADMIN USER: '
    puts "Email: #{user.email}"
  end
end
