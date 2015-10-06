class CreateListingMembers < ActiveRecord::Migration
  def change
    create_table :listing_members do |t|
      ## Many-to-many between users and listings
      t.belongs_to :user, null: false
      t.belongs_to :listing, null: false
      t.index [:user_id, :listing_id], unique: true
      
      ## Textual information
      t.text :review
      
      ## Rating
      t.integer :rating
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
