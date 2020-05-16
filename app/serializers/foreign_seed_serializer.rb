class ForeignSeedSerializer < ApplicationSerializer
  key :foreign_seed
  collection_key :foreign_seeds
  serialize(
    :id,
    :type,
    :crop_name,
    :genus,
    :family,
    :species,
    :resistant,
    :susceptible,
    :sub_texa,
    :material_type,
    :classification
  )

  serialize :repatriation_info, with: RepatriationInfoSerializer
end
