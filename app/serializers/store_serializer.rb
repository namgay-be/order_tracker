class StoreSerializer < ApplicationSerializer
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
  serialize :service_area, with: ServiceAreaSerializer
  serialize :items, with: ItemSerializer
  serialize :contacts, with: ContactSerializer
  serialize :photos, with: PhotoSerializer
end