class PostSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id,
             :message,
             :privacy,
             :posted_at
  
  
  ## Relationships
  has_one  :user
  has_one  :author
  has_many :attachments, serializer: FileSerializer
  
  
  ## Attribute serializers
  def privacy
    object.privacy.name
  end
end