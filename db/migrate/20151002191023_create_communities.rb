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
      
      # Photos
      t.attachment :avatar
      t.attachment :logo
      
      # Date fields
      t.date     :founded_at
      t.datetime :archived_at
      
      # Category (enum)
      t.integer :category, null: false, index: true
      
      # Permissions
      t.integer :manage_profile,    null: false
      t.integer :manage_members,    null: false
      t.integer :manage_children,   null: false
      t.integer :manage_posts,      null: false
      t.integer :manage_listings,   null: false
      t.integer :manage_resources,  null: false
      t.integer :manage_events,     null: false
      
      # Privacy
      t.integer :access_events,     null: false
      t.integer :access_resources,  null: false
      t.integer :access_statistics, null: false
      
      # Location
      t.belongs_to :location, index: true
      
      # Parent community
      t.belongs_to :community, index: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
