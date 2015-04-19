class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.references :restaurant, index: true

      t.timestamps
    end
    
    add_index :favorites, [:user_id, :restaurant_id], :unique => true
  end
end
