class CreateListingSkills < ActiveRecord::Migration
  def change
    create_table :listing_skills do |t|
      # Many-to-many relationship between listings and tags
      t.belongs_to :listing, null: false
      t.belongs_to :tag,  null: false
      t.index [:listing_id, :tag_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
