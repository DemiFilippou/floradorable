Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :update] do
    resources :user_plants do
      get 'water'
    end

    resources :pushies, only: [:create]
  end

  post 'login', to: 'users#login'
  get '/search', to: 'plants#search'
end
