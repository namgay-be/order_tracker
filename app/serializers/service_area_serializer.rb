class ServiceAreaSerializer < ApplicationSerializer
  key :service_area
  collection_key :service_areas
  serialize(
    :id,
    :name,
    :creation_date
  )

  serialize :address, with: AddressSerializer
end