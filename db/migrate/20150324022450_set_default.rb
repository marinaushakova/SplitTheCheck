class SetDefault < ActiveRecord::Migration
  def change
    change_column :restaurants, :upvote, :integer, default: 0
    change_column :restaurants, :downvote, :integer, default: 0
  end
  
end
