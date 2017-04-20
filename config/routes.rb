Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :users, only: [:show]
  resources :tasks
  resources :surveys
  resources :reminders, only: [:edit, :update, :destroy]
  patch '/tasks/:id/complete', to: 'tasks#complete'
  resources :jobs
  root to: 'static_pages#home'
end
