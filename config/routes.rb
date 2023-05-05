Rails.application.routes.draw do
  scope '/api' do
    scope '/users' do
      post '/sign_in', to: 'sessions#create'
      post '/sign_up', to: 'users#create'
    end
  end

  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
