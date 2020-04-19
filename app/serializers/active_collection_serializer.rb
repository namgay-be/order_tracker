class ActiveCollectionSerializer < ApplicationSerializer
  key :active_collection
  collection_key :active_collections
  serialize(
    :id,
    :gene_bank_id,
    :weight,
    :packets
  )

  serialize :location, with: LocationSerializer
end
