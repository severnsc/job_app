Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :users, only: [:show]
  resources :tasks
  resources :surveys
  resources :answers, only: [:create]
  resources :reminders, only: [:edit, :update, :destroy]
  resources :submissions, only: [:edit, :update]
  patch '/tasks/:id/complete', to: 'tasks#complete'
  get '/jobs/:id/survey', to: 'jobs#survey', as: 'job_survey'
  get '/jobs/:id/survey/submit', to: 'jobs#survey_submit', as: 'job_survey_submission'
  resources :jobs
  root to: 'static_pages#home'
end
