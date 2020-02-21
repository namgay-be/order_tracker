class SeedInfoSerializer < ApplicationSerializer
  key :seed_info
  serialize(
    :id,
    :crop_name,
    :local_name,
    :local_variety_name,
    :family,
    :genus,
    :species,
    :sub_texa,
    :material_type,
    :classification,
    :resistant,
    :susceptible,
    :sample_status,
    :seed_status
  )
end