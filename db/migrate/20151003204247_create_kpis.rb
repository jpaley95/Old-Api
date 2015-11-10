class CreateKpis < ActiveRecord::Migration
  def change
    create_table :kpis do |t|
      ## Textual information
      t.string :name, null: false
      t.text :details
      
      ## Completed flag
      t.boolean :is_completed, null: false, default: false
      
      ## Date information
      t.datetime :started_at
      t.datetime :finished_at
      
      ## Belongs to a team
      t.belongs_to :team, null: false, index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
