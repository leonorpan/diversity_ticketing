Rails.application.routes.draw do
  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'sessions', only: [:create]

  resources :users, controller: 'users', only: [:show, :edit, :update]
  resources :users, controller: 'clearance/users', only: [:create] do
    resource :password,
      controller: 'clearance/passwords',
      only: [:create, :edit, :update]
  end

  resources :events do
    resources :applications, only: [:show, :new, :create, :destroy]
  end

  resources :admin_events, except: [:edit, :update] do
    member do
      post :approve
    end
  end

  resources :tags

  get '/sign_in', to: 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out', to: 'clearance/sessions#destroy', as: 'sign_out'
  get '/sign_up', to: 'clearance/users#new', as: 'sign_up'
  get '/past_events', to: 'events#index_past', as: :past_events
  get '/admin', to: 'admin_events#index'
  get '/events/:id/admin', to: 'admin_events#show', as: :event_admin
  post '/events/preview', to: 'events#preview', as: :event_preview
  get '/about', to: 'home#about', as: :about
  get '/faq', to: 'home#faq', as: :faq

  root 'home#home'
end
