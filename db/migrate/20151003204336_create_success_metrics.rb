class CreateSuccessMetrics < ActiveRecord::Migration
  def change
    create_table :success_metrics do |t|
      ## Textual information
      t.text :description
      
      ## Progress
      t.integer :progress, null: false, default: 0
      
      ## Belongs to a kpi
      t.belongs_to :kpi, null: false, index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
