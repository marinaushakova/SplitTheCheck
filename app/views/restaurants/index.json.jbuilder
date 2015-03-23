json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :address, :city, :state, :zip, :upvote, :downvote
  json.url restaurant_url(restaurant, format: :json)
end
