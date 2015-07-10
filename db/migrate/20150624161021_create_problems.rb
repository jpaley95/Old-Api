class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      # Text fields
      t.string :name,         null: false
      t.text   :text,         null: false
      
      # Photo
      t.attachment :photo,    null: false
      
      # Location
      t.belongs_to :location,              index: true
      
      # Creator
      t.belongs_to :user,     null: false, index: true
      
      # Always include timestamps
      t.timestamps
    end
  end
end
