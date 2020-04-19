class LocationSerializer < ApplicationSerializer
  key :location
  collection_key :locations
  serialize(
    :id,
    :name
  )
end
