Rails.application.routes.draw do
  
  devise_for :users
  root :to => "restaurants#index"
  
  controller :restaurants do
    get 'restaurants/upvote' => 'restaurants#upvote', as: :upvote
    get 'restaurants/downvote' => 'restaurants#downvote', as: :downvote
    get 'restaurants/comment' => 'restaurants#comment', as: :comment
    get 'restaurants/favorite' => 'restaurants#make_favorite', as: :make_favorite
    get 'restaurants/unfavorite' => 'restaurants#remove_from_favorite', as: :remove_from_favorite
  end

  resources :restaurants, except: [:destroy, :edit]
  resources :favorites, only: [:create, :destroy]
  resources :comments, only: [:create]
  resources :users, only: [:show, :create]
  #resources :votes, except: [:destroy, :edit, :update]
end
