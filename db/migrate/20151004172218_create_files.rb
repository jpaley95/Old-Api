class CreateFiles < ActiveRecord::Migration
  def change
    create_table :files do |t|
      ## STI type (image, document)
      t.string :type, null: false
      
      ## Optional name and description
      t.string :name
      t.text :description
      
      ## Actual file
      t.attachment :payload, null: false
      
      ## User who uploaded the file
      t.belongs_to :user, null: false, index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
