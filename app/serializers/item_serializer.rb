class ItemSerializer < ApplicationSerializer
  key :item
  collection_key :items
  serialize(
    :id,
    :name,
    :price,
    :available,
    :additional_info,
    :creation_date
  )

  serialize :photos, with: PhotoSerializer
end