class ForeignSeed < Seed
  has_one :foreign_seed_info, inverse_of: :foreign_seed, dependent: :destroy
  has_one :repatriation_info, inverse_of: :foreign_seed, dependent: :destroy

  accepts_nested_attributes_for :foreign_seed_info, :repatriation_info
end
