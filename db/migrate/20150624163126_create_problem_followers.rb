class CreateProblemFollowers < ActiveRecord::Migration
  def change
    create_table :problem_followers do |t|
      # Many-to-many relationship between users and problems
      t.belongs_to :follower, null: false
      t.belongs_to :followed, null: false
      t.index [:follower_id, :followed_id], unique: true
      
      # Always include timestamps
      t.timestamps
    end
  end
end
