class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      # School
      t.belongs_to :school, index: true
      t.string :school_name
      
      # Degree
      t.belongs_to :degree, index: true, null: false
      
      # Date fields
      t.date :started_at
      t.date :finished_at
      
      # Text fields
      t.text   :grades
      t.text   :activities
      t.text   :classes
      t.text   :honors
      t.text   :description
      
      # User
      t.belongs_to :user, index: true, null: false
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
