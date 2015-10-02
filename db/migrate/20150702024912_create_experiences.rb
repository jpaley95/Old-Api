class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      # Text fields
      t.string :title
      t.text   :description
      
      # Team or organization
      t.string     :organization
      t.belongs_to :team,         index: true
      
      # Date fields
      t.date :started_at
      t.date :finished_at
      
      # Location
      t.belongs_to :location,     index: true
      
      # User
      t.belongs_to :user,         index: true, null: false
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
