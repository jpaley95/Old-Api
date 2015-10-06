class CreateTeamPostsPermissions < ActiveRecord::Migration
  def change
    create_table :team_posts_permissions do |t|
      # Many-to-many relationship between teams and permissions
      t.belongs_to :team,    null: false
      t.belongs_to :permission, null: false
      t.index [:team_id, :permission_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
