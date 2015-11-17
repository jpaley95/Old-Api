class ListingMemberSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id,
             :review, :rating,
             :created_at
  
  
  ## Relationships
  has_one :user
  has_one :listing
end