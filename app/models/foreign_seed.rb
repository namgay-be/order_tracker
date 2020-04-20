class ForeignSeed < Seed
  has_one :repatriation_info, inverse_of: :foreign_seed, dependent: :destroy

  accepts_nested_attributes_for :repatriation_info

  scope :by_crop_name, ->(crop_name) { where(crop_name: crop_name) }
  scope :by_seed_status, ->(seed_status) { where(seed_status: seed_status) }
  scope :by_classification, ->(classification) { where(classification: classification) }
  scope :by_donor_name, ->(donor) { joins(:repatriation_info).where(repatriation_infos: {donor_name: donor}) }
  scope :by_requires_multiplication, ->(flag) { where(requires_multiplication: flag) }

  def self.search(query)
    joins(:repatriation_info).where(
      "CONCAT_WS(
         ' ',
         seeds.crop_name,
         seeds.classification,
         seeds.seed_status,
         repatriation_infos.repatriation_number,
         repatriation_infos.donor_name
         ) iLIKE ?",
      "%#{query&.squish}%"
    )
  end
end
