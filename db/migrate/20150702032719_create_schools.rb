class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      # Name of school
      t.string :name, null: false
      
      # Location
      t.belongs_to :location, index: true
      
      # Picture (eventually)
      t.attachment :photo
      
      # Always include timestamps
      t.timestamps
    end
  end
end
