class RemoveUpvoteFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :upvote, :integer
  end
end
