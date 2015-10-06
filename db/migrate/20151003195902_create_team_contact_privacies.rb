class CreateTeamContactPrivacies < ActiveRecord::Migration
  def change
    create_table :team_contact_privacies do |t|
      # Many-to-many relationship between teams and privacies
      t.belongs_to :team,    null: false
      t.belongs_to :privacy, null: false
      t.index [:team_id, :privacy_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
