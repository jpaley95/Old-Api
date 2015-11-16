class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      # Personal information
      t.string :name, null: false
      
      # Status information
      t.string :tagline
      t.string :contact
      t.text   :summary
      t.string :stage
      
      # Social information
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      t.string :github
      
      # Sectors
      t.boolean :commercial
      t.boolean :research
      t.boolean :social
      
      # Date fields
      t.date :founded_at
      
      # Location
      t.belongs_to :location, index: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
