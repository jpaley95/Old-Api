class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      ## Author of the post
      t.belongs_to :handle, null: false, index: true
      
      ## User who wrote the post
      t.belongs_to :user, null: false, index: true
      
      ## Post content
      t.text :content, null: false
      
      ## Post privacy
      t.belongs_to :privacy, null: false, index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
