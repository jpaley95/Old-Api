class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      # Name of school
      t.string :name, null: false
      
      # Location
      t.belongs_to :location, index: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
