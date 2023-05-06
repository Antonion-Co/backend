Rails.application.routes.draw do
  scope '/api' do
    scope '/users' do
      get '/current_user', to: 'users#show'
      post '/sign_in', to: 'sessions#create'
      post '/sign_up', to: 'users#create'
    end

    scope '/app_services' do
      get '/', to: 'app_services#index'
      post '/', to: 'app_services#create'
    end

    scope '/services' do
      post '/', to: 'services#create'
    end

    scope '/messages' do
      post '/', to: 'messages#create'
    end
  end

  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
