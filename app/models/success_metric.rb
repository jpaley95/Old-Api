class SuccessMetric < ActiveRecord::Base
  ## Database Fields
  # t.text    "description"
  # t.integer "progress",    default: 0, null: false
  # t.integer "kpi_id",                  null: false
  
  
  
  ## Relationships
  belongs_to :kpi
  has_many :metric_changes
  
  
  
  ## Validation
  validates :progress, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :kpi,      presence: true
end
