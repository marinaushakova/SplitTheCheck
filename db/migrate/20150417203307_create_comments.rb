class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :message
      t.references :restaurant, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
