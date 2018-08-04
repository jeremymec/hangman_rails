Rails.application.routes.draw do
  get 'guesses/create'

  root :to => "home#welcome"

  resources :games, param: :slug, only: [:show, :create, :new] do
    member do
      post 'reveal_word'
      post 'hide_word'
    end
  end

  resources :guesses, only: [:create]

end
