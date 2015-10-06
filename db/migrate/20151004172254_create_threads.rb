class CreateThreads < ActiveRecord::Migration
  def change
    create_table :threads do |t|
      ## Type field (STI)
      t.string :type, null: false, index: true
      
      ## User who created the thread
      t.belongs_to :user, null: false, index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
