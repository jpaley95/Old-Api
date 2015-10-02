class CreateCommunityMembers < ActiveRecord::Migration
  def change
    create_table :community_members do |t|
      # Many-to-many relationship between users and communities
      t.belongs_to :user,      null: false
      t.belongs_to :community, null: false
      t.index [:user_id, :community_id], unique: true
      
      # Role
      t.belongs_to :role, null: false
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
