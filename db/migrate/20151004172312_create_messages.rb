class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      ## User who wrote the message
      t.belongs_to :user, null: false, index: true
      
      ## Message
      t.text :content, null: false
      
      ## Thread
      t.belongs_to :thread, null: false, index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
