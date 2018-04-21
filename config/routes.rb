Rails.application.routes.draw do
  get 'guesses/create'

  root :to => "home#welcome"

  resources :games, only: [:show, :create, :new] do
    member do
      post 'reveal_word'
    end
  end

  resources :guesses, only: [:create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
