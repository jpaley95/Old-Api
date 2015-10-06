class MetricChange < ActiveRecord::Base
  # Database Fields
  # t.text    "comment"
  # t.integer "old_progress", null: false
  # t.integer "new_progress", null: false
  # t.integer "metric_id",    null: false
  # t.integer "user_id",      null: false
  
  
  
  # Relationships
  belongs_to :metric
  belongs_to :user
  
  
  
  # Validation
  validates :metric, presence: true
  validates :user, presence: true
  validates :old_progress, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :new_progress, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
