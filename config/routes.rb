Lion::Application.routes.draw do
  namespace :api do
    resources :tasks, only: [:index, :create, :update, :destroy]
    resources :comments, only: [:create, :update, :destroy]

    resources :users do
      collection do
        get :me
      end
    end

    resources :task_completions, only: :create do
      collection do
        delete :destroy
      end
    end

    resources :pull_requests, only: :create
    resources :scores, only: :index
    resources :weekly_winnings, only: :index
    resources :stats, only: :index
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '*a', to: 'home#index'

  root 'home#index'
end
