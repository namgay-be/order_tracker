class ForeignSeedInfo < ApplicationRecord
  belongs_to :foreign_seed, inverse_of: :foreign_seed_info
end
