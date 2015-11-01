class LocationSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :description,
             :street, :city, :state, :zip, :country,
             :latitude, :longitude
end