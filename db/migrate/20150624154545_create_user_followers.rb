class CreateUserFollowers < ActiveRecord::Migration
  def change
    create_table :user_followers do |t|
      # Many-to-many relationship for users
      t.belongs_to :follower, null: false
      t.belongs_to :followed, null: false
      t.index [:follower_id, :followed_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
