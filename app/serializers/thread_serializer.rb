class ThreadSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id, :type,
             :created_at
  
  
  ## Relationships
  has_one  :author
  has_many :messages
  has_many :participants
end