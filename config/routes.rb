# frozen_string_literal: true

Rails.application.routes.draw do
	mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
	 get '/user_dashboard', to: 'userdashboard#index'
  devise_for :users
	scope "/admin" do
	  resources :users
	end
  root to: "home#index"
end
