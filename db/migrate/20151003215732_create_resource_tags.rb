class CreateResourceTags < ActiveRecord::Migration
  def change
    create_table :resource_tags do |t|
      # Many-to-many relationship between resources and tags
      t.belongs_to :resource, null: false
      t.belongs_to :tag,      null: false
      t.index [:resource_id, :tag_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
