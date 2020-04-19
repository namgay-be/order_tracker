class BaseCollectionSerializer < ApplicationSerializer
  key :base_collection
  collection_key :base_collections
  serialize(
    :id,
    :gene_bank_id,
    :germination_weight,
    :germination_packets,
    :regeneration_weight,
    :regeneration_packets,
    :rest_weight,
    :rest_packets
  )

  serialize :locations, with: LocationSerializer
end