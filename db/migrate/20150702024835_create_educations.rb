class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      # School
      t.belongs_to :school,    index: true, null: false
      
      # Date fields
      t.date :started_at
      t.date :finished_at
      
      # Text fields
      t.string :degree,        index: true
      t.string :field,         index: true
      t.text   :grades
      t.text   :activities
      t.text   :classes
      t.text   :honors
      t.text   :description
      
      # User
      t.belongs_to :user,      index: true, null: false
      
      # Always include timestamps
      t.timestamps
    end
  end
end
