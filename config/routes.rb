Rails.application.routes.draw do
  controller :restaurants do
    get 'restaurants/upvote' => 'restaurants#upvote', as: :upvote
    get 'restaurants/downvote' => 'restaurants#downvote', as: :downvote
  end

  resources :restaurants, except: [:destroy, :edit]

end
