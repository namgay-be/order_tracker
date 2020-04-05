class ForeignSeedSerializer < ApplicationSerializer
  key :foreign_seed
  collection_key :foreign_seeds
  serialize(
    :id,
    :type
  )

  serialize :foreign_seed_info, with: ForeignSeedInfoSerializer
  serialize :repatriation_info, with: RepatriationInfoSerializer
end