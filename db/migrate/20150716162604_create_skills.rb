class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      # Many-to-many relationship between users and tags
      t.belongs_to :user, null: false
      t.belongs_to :tag,  null: false
      t.index [:user_id, :tag_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
