class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      ## Personal information
      t.string :name, null: false
      
      ## Textual information
      t.text :overview
      
      ## Social information
      t.string :website
      t.string :facebook
      t.string :twitter
      
      ## Privacy
      t.belongs_to :privacy, null: false
      
      ## Community
      t.belongs_to :community, null: false, index: true
      
      ## Locations
      t.belongs_to :location, index: true
      
      ## Avatar
      t.belongs_to :avatar, index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
