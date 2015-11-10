class SuccessMetricSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id,
             :description,
             :progress,
             :created_at
  
  
  ## Relationships
  has_one  :kpi
  has_many :changes
end