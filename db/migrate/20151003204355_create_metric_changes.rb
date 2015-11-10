class CreateMetricChanges < ActiveRecord::Migration
  def change
    create_table :metric_changes do |t|
      ## Textual information
      t.text :comment
      
      ## Progress
      t.integer :old_progress, null: false
      t.integer :new_progress, null: false
      
      ## Belongs to a metric
      t.belongs_to :metric, null: false, index: true
      
      ## User who made the change
      t.belongs_to :user, null: false, index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
