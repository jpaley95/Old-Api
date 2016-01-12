class CreateMessageFiles < ActiveRecord::Migration
  def change
    create_table :message_files do |t|
      # Many-to-many relationship between messages and files
      t.belongs_to :message, null: false, index: true
      t.belongs_to :file, null: false
      t.index :file_id, unique:true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
