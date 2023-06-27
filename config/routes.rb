# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'application#index'
  devise_for :users, path: 'api/v1/users/'

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'users/signup', to: 'users/registrations#signup'
        post 'users/login', to: 'users/sessions#login'
        delete 'users/logout', to: 'users/sessions#logout'
        get 'users/my_account', to: 'users/sessions#my_account'
      end

      resources :incomes, only: %i[index create show update destroy]
      resources :expenses, only: %i[index create show update destroy]
      resources :budgets, only: %i[index create show update destroy]
      resources :categories, only: %i[index create]
    end
  end
end
