class SeedListSerializer < ApplicationSerializer
  key :seed
  collection_key :seeds
  serialize(
    :id,
    :type,
    :crop_name,
    :seed_status,
    :unique_identifier,
    :classification,
    :family,
    :creation_date,
    :creator_name
  )
end
