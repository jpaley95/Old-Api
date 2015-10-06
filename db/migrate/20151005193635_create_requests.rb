class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      ## Textual information
      t.string :message
      t.string :email
      
      ## Date information
      t.datetime :accepted_at
      t.datetime :denied_at
      
      ## Enumerated information
      t.integer :role
      t.integer :category, null: false
      
      ## Relationships
      t.belongs_to :requestor,  null: false, index: true
      t.belongs_to :actor,                   index: true
      t.belongs_to :initiator,  null: false, index: true
      t.belongs_to :terminator,              index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
