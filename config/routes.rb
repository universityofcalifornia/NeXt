Rails.application.routes.draw do

  resources :badges

  resources :projects do
    scope module: 'projects' do
      resources :votes, only: [:create]
      resources :documents
    end
  end

  resources :ideas do
    scope module: 'ideas' do
      resources :votes, only: [:create]
    end
  end

  resources :comments, only: [:create]

  get '/comments/new/(:parent_id)', to: 'comments#new', as: 'new_comment'

  resources :competencies

  resources :resources

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    scope module: 'users' do
      resources :badges, only: [:index, :new, :create, :update, :destroy]
    end
  end

  resource :auth, controller: 'auth', only: [:destroy]

  resources :events do
    collection do
      get 'logged_in'
    end
  end

  get 'invites/accept/:id', to: 'invites#accept', as: 'accept_invitation'
  get 'invites/decline/:id', to: 'invites#decline', as: 'decline_invitation'

  resources :groups do
    collection do
      get 'ajax_index'
      post 'ajax_create'
    end
  end

  resource :user_groups

  namespace :auth do
    get '/oauth2/:id', to: 'oauth2#return', as: :oauth2_return, constraints: lambda { |request| request.query_parameters.include? 'code' }
    get '/oauth2/:id', to: 'oauth2#launch', as: :oauth2_launch
    resource :local, controller: 'local', only: [:new, :create]
    namespace :local do
      resource :registration, controller: 'registration', only: [:new, :create]
    end
  end

  namespace :local do
    resources :users
  end

  get 'search', to: 'search#default'
  post 'search', to: 'search#default'

  get 'about', to: 'home#about'

  root 'home#index'

end
