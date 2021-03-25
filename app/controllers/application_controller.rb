# frozen_string_literal: true

# application_controller.rb
class ApplicationController < ActionController::Base
  protected

  def authorize_admin
    return if current_user.admin?

    render file: "#{Rails.root}/public/404", status: :not_found
  end
end
