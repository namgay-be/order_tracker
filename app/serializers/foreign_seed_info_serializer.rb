class ForeignSeedInfoSerializer < ApplicationSerializer
  key :foreign_seed_info
  collection_key :foreign_seed_infos
  serialize(
    :id,
    :crop_name,
    :genus,
    :family,
    :species,
    :sub_texa,
    :material_type,
    :classification,
    :characteristics,
  )
end