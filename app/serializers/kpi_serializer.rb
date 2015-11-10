class KpiSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id, :name,
             :details,
             :is_completed,
             :created_at, :started_at, :finished_at
  
  
  ## Relationships
  has_one  :team
  has_many :success_metrics
end