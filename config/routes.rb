Rails.application.routes.draw do
  
  

  resources :favorites

  devise_for :users
  root :to => "restaurants#index"
  
  controller :restaurants do
    get 'restaurants/upvote' => 'restaurants#upvote', as: :upvote
    get 'restaurants/downvote' => 'restaurants#downvote', as: :downvote
    get 'restaurants/comment' => 'restaurants#comment', as: :comment
  end

  resources :restaurants, except: [:destroy, :edit]
  resources :comments
  resources :users, only: [:show]
  #resources :votes, except: [:destroy, :edit, :update]
end
