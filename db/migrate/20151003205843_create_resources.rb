class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      ## Personal information
      t.string :name, null: false
      
      ## Textual information
      t.string :contact
      t.text :overview
      
      ## Social information
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      
      ## Privacy
      t.belongs_to :privacy, null: false
      
      ## Community
      t.belongs_to :community, null: false, index: true
      
      ## Locations
      t.belongs_to :location, index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
