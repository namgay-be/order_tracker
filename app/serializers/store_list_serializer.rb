class StoreListSerializer < ApplicationSerializer
  key :store
  collection_key :stores
  serialize(
    :id,
    :name,
    :category,
    :phone_1,
    :phone_2,
    :email,
    :available,
    :creation_date
  )

  serialize :address, with: AddressSerializer
  serialize :photos, with: PhotoSerializer
end
