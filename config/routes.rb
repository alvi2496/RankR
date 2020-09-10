Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :students, controllers: {
    registrations: 'students/registrations',
    sessions: 'students/sessions'
  }

  resources :assignments, only: [:index] do
    resources :ranks, only: [:index, :new, :create] 
  end
end
