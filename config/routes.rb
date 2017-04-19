Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :users, only: [:show]
  resources :tasks
  patch '/tasks/:id/complete', to: 'tasks#complete'
  resources :jobs
  root to: 'static_pages#home'
end
