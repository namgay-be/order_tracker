class ForeignSeed < Seed
  has_one :repatriation_info, inverse_of: :foreign_seed, dependent: :destroy

  accepts_nested_attributes_for :repatriation_info
end
