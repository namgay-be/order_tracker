class AddressSerializer < ApplicationSerializer
  key :address
  collection_key :addresses
  serialize(
    :id,
    :dzongkhag,
    :gewog,
    :village,
    :sector,
    :longitude,
    :latitude,
    :additional_info
  )
end
