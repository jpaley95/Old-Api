class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      ## Creator
      t.belongs_to :handle, null: false, index: true
      t.belongs_to :user,   null: false, index: true
      
      ## Textual information
      t.string :title, null: false
      t.text :description
      
      ## Location
      t.belongs_to :location, index: true
      
      ## Numerical information
      t.integer :positions # (available spots)
      
      ## Enumerated information
      t.integer :category # (position type)
      t.integer :hours # (full_time, part_time)
      
      ## Duration
      t.datetime :started_at
      t.datetime :finished_at
      
      ## Deadline
      t.datetime :closed_at
      
      ## Salary information
      t.integer :salary_min
      t.integer :salary_max
      t.integer :salary_period # (hour, week, month, year)
      
      ## Equity information
      t.integer :equity_min
      t.integer :equity_max
      
      ## Privacy
      t.belongs_to :privacy, null: false, index: true
      
      ## Always include timestamps
      t.timestamps null: false
    end
  end
end
