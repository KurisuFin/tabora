Tabora::Application.routes.draw do

  resources :acts, only: [:update, :destroy]
  resources :battles, only: [:update, :destroy]
  resources :participations, only: [:create, :destroy]
	resources :sessions, only: [:new, :create]

  resources :users, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :games

  resources :events do
		resources :tournaments, only: [:new, :create]
		resources :operators, only: [:new, :create]
	end

	resources :tournaments, only: [:index, :show, :edit, :update, :destroy]
	resources :operators, only: [:destroy]

	get 'login', to: 'sessions#new'
	delete 'logout', to: 'sessions#destroy'
	get 'signup', to: 'users#new'

	root 'events#home'
end
