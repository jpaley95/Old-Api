class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      # Textual information
      t.string :name, null: false
      t.string :headline
      t.string :video
      t.string :domains
      t.text   :policy
      t.text   :description
      
      # Social information
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      
      # Date fields
      t.date     :founded_at
      t.datetime :archived_at
      
      # Category (enum)
      t.integer :category, null: false, index: true
      
      # Permissions (internal access)
      t.belongs_to :profile_permission,    null: false
      t.belongs_to :members_permission,    null: false
      t.belongs_to :children_permission,   null: false
      t.belongs_to :statistics_permission, null: false
      t.belongs_to :posts_permission,      null: false
      t.belongs_to :listings_permission,   null: false
      t.belongs_to :resources_permission,  null: false
      t.belongs_to :events_permission,     null: false
      
      # Privacy (external access)
      t.belongs_to :events_privacy,    null: false
      t.belongs_to :resources_privacy, null: false
      
      # Location
      t.belongs_to :location, index: true
      
      # Images
      t.belongs_to :logo,   index: true
      t.belongs_to :avatar, index: true
      
      # Parent community
      t.belongs_to :community, index: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
