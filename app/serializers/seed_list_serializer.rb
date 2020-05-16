class SeedListSerializer < ApplicationSerializer
  key :seed
  collection_key :seeds
  serialize(
    :id,
    :type,
    :seed_status,
    :unique_identifier,
    :classification
  )
end
