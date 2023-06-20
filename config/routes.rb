Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'application#index'
  devise_for :users, path: 'api/v1/users/', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/v1/users/sessions',
    registrations: 'api/v1/users/registrations'
  }

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        get 'users/my_account', to: 'users/sessions#my_account'
      end
    end
  end
end
