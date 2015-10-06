class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
      # Many-to-many relationship between teams and tags
      t.belongs_to :team, null: false
      t.belongs_to :tag,  null: false
      t.index [:team_id, :tag_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
