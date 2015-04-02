require 'sidekiq/web'

Rails.application.routes.draw do
  root 'principals#pre_qualification_form'

  get 'error', to: 'pages#error'

  resources :principals, param: :token do
    collection do
      get 'prequalify',  action: 'pre_qualification_form'
      post 'prequalify', action: 'pre_qualification'
      get 'reject',      action: 'rejection_form'
    end

    resources :firms, only: :index do
      resource :questionnaire, only: [:edit, :update]
      resources :advisers
      resources :subsidiaries, only: [] do
        member do
          post 'convert'
        end
      end
    end

    namespace :lookup do
      resources :advisers, only: :show
    end
  end

  resource :contact, only: :create

  namespace :admin do
    root 'pages#home'
    resources :advisers, only: [:index, :show, :edit, :update]
    resources :firms, only: [:index, :show] do
      resources :advisers, only: :index
    end
    namespace :lookup do
      resources :advisers, only: :index
      resources :firms, only: :index
      resources :subsidiaries, only: :index
    end
    resources :principals, only: [:index, :show, :edit, :update]
  end

  if Authentication.required?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      Authentication.authenticate(username, password)
    end

    mount Sidekiq::Web, at: '/sidekiq'
  end
end
