Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :users, only: [:show]
  resources :tasks
  root to: 'static_pages#home'
end
