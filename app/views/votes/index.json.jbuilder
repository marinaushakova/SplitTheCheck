json.array!(@votes) do |vote|
  json.extract! vote, :id, :vote, :user_id, :restaurant_id
  json.url vote_url(vote, format: :json)
end
