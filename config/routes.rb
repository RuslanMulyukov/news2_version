News2Clone::Application.routes.draw do

  get "home/index"

  devise_for :users

  resources :users do
    resources :articles do
      get "search", :on => :collection
      get "sort", :on => :collection
    end
    resources :categories
    resources :comments
    resources :votes
  end

  root :to => "home#index"
end

