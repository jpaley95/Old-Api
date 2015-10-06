class CreateCommunityTeams < ActiveRecord::Migration
  def change
    create_table :community_teams do |t|
      # Many-to-many relationship between teams and communities
      t.belongs_to :team,      null: false
      t.belongs_to :community, null: false
      t.index [:team_id, :community_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
