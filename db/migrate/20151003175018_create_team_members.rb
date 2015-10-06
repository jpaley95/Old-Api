class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      # Many-to-many relationship between users and teams
      t.belongs_to :user, null: false
      t.belongs_to :team, null: false
      t.index [:user_id, :team_id], unique: true
      
      # Role
      t.belongs_to :role, null: false
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
