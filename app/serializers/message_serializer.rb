class MessageSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id,
             :content,
             :created_at, :updated_at
  
  
  ## Relationships
  has_one  :user
  has_one  :author
  has_one  :thread
  has_many :attachments, serializer: FileSerializer
end