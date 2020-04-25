class DistributionInfo < ApplicationRecord
  belongs_to :customer, inverse_of: :distribution_infos
  belongs_to :seed, inverse_of: :distribution_infos

  enum package_type: {
    active_collection: 0,
    duplicate: 1,
    germination: 2,
    regeneration: 3,
    rest: 4,
    characterization: 5
  }
end
