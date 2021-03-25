# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
	scope "/admin" do
	  resources :users
	end
  root to: "home#index"
end
