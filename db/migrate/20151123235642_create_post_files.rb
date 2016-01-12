class CreatePostFiles < ActiveRecord::Migration
  def change
    create_table :post_files do |t|
      # Many-to-many relationship between posts and files
      t.belongs_to :post, null: false, index: true
      t.belongs_to :file, null: false
      t.index :file_id, unique:true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
