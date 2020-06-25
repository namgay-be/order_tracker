class SeedSerializer < ApplicationSerializer
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
    :requires_multiplication,
    :creator_name,
    :creation_date
  )

  serialize :collection_info, with: CollectionInfoSerializer
  serialize :cultivation_info, with: CultivationInfoSerializer
  serialize :donor_info, with: DonorInfoSerializer
  serialize :donor_field_info, with: DonorFieldInfoSerializer
  serialize :seed_info, with: SeedInfoSerializer
  serialize :test_details, with: TestDetailSerializer
  serialize :gene_bank, with: GeneBankSerializer
end
