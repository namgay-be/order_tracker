class ForeignSeed < Seed
  has_one :foreign_seed_info, inverse_of: :foreign_seed
  has_one :repatriation_info, inverse_of: :foreign_seed
end
