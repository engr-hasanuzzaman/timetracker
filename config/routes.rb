Internal::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :approval_chains do
    member { post :assign }
    collection { post :create_chain }
  end

  resources :leave_tracker

  resources :users do
    member do
      get :leave
      get :team
    end

    collection do
      get :download
    end
  end

  # leaves controller resources generates wrong typo in url helper
  get '/leaves', to: 'leaves#index', as: 'leaves'
  get '/leaves/new', to: 'leaves#new', as: 'new_leave'
  post '/leaves', to: 'leaves#create'
  get '/leaves/:id', to: 'leaves#show', as: 'leave'
  get '/leaves/:id/edit', to: 'leaves#edit', as: 'edit_leave'
  put '/leaves/:id', to: 'leaves#update'
  delete '/leaves/:id', to: 'leaves#destroy'
  post 'leaves/:id/approve', to: 'leaves#approve', as: 'approve_leave'
  post 'leaves/:id/reject', to: 'leaves#reject', as: 'reject_leave'

  resources :attendances do
    collection do
      get :monthly_summary
      get :download
    end
  end

  resources :salaats

  resources :weekends do
    member do
      post :assign
    end
  end

  root :to => 'dashboard#index'
end
