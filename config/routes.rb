Rails.application.routes.draw do

  resources :projects

  resources :ideas do
    scope module: 'ideas' do
      resources :votes, only: [:create]
    end
  end

  resources :competencies

  resources :users, only: [:index, :show, :edit, :update]

  resource :auth, controller: 'auth', only: [:destroy]

  resources :events do
    collection do
      get 'logged_in'
    end
  end

  resources :groups do
    member do
      post 'add_event'
    end

  end

  namespace :auth do
    get '/oauth2/:id', to: 'oauth2#return', as: :oauth2_return, constraints: lambda { |request| request.query_parameters.include? 'code' }
    get '/oauth2/:id', to: 'oauth2#launch', as: :oauth2_launch
    resource :local, controller: 'local', only: [:new, :create]
  end

  namespace :local do
    resources :users
  end

  get 'search', to: 'search#default'
  post 'search', to: 'search#default'

  root 'home#index'

end
