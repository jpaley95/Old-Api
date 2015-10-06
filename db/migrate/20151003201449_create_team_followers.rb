class CreateTeamFollowers < ActiveRecord::Migration
  def change
    create_table :team_followers do |t|
      # Many-to-many relationship between users and teams
      t.belongs_to :team, null: false
      t.belongs_to :user, null: false
      t.index [:team_id, :user_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
