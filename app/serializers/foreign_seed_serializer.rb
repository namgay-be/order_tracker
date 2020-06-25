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
    :seed_status,
    :classification,
    :creator_name,
    :creation_date
  )

  serialize :repatriation_info, with: RepatriationInfoSerializer
  serialize :test_details, with: TestDetailSerializer
  serialize :gene_bank, with: GeneBankSerializer
end
