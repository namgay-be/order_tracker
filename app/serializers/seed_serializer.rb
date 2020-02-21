class SeedSerializer < ApplicationSerializer
  key :seed
  collection_key :seeds
  serialize(
    :id,
    :type
  )

  serialize :collection_info, with: CollectionInfoSerializer
  serialize :cultivation_info, with: CultivationInfoSerializer
  serialize :donor_info, with: DonorInfoSerializer
  serialize :donor_field_info, with: DonorFieldInfoSerializer
  serialize :seed_info, with: SeedInfoSerializer
end
