class CryoSerializer < ApplicationSerializer
  key :seed
  collection_key :seeds
  serialize(
    :id,
    :type,
    :crop_name,
    :family,
    :genus,
    :species,
    :sub_texa,
    :material_type,
    :classification,
    :resistant,
    :susceptible,
    :seed_status,
    :requires_multiplication
  )

  serialize :collection_info, with: CollectionInfoSerializer
  serialize :cultivation_info, with: CultivationInfoSerializer
  serialize :donor_info, with: DonorInfoSerializer
  serialize :donor_field_info, with: DonorFieldInfoSerializer
  serialize :seed_info, with: SeedInfoSerializer
  serialize :test_details, with: TestDetailSerializer
end