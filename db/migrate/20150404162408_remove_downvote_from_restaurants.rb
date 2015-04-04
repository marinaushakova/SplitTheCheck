class RemoveDownvoteFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :downvote, :integer
  end
end
