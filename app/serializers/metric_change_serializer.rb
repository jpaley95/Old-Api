class SuccessMetricSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id,
             :comment,
             :old_progress, :new_progress,
             :metric_id,
             :created_at
  
  
  ## Relationships
  has_one :user
  has_one :metric
end