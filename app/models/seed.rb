class Seed < ApplicationRecord
  has_one :collection_info, inverse_of: :seed, dependent: :destroy
  has_one :cultivation_info, inverse_of: :seed, dependent: :destroy
  has_one :donor_field_info, inverse_of: :seed, dependent: :destroy
  has_one :donor_info, inverse_of: :seed, dependent: :destroy
  has_one :seed_info, inverse_of: :seed, dependent: :destroy

  include Klass::Seed

  accepts_nested_attributes_for(
    :seed_info,
    :donor_field_info,
    :donor_info,
    :collection_info,
    :cultivation_info,
    allow_destroy: true
  )

  scope :by_crop_name, ->(crop_name) { joins(:seed_info).where(seed_infos: { crop_name: crop_name }) }
  scope :by_local_name, ->(local_name) { joins(:seed_info).where(seed_infos: { local_name: local_name }) }
  scope :by_local_variety, ->(local_variety) { joins(:seed_info).where(seed_infos: { local_variety_name: local_variety }) }
  scope :by_seed_status, ->(seed_status) { joins(:seed_info).where(seed_infos: { seed_status: seed_status }) }
  scope :by_classification, ->(classification) { joins(:seed_info).where(seed_infos: { classification: classification }) }
  scope :by_donor_name, ->(donor) { joins(:donor_info).where(donor_infos: { donor_name: donor }) }
  scope :by_dzongkhag, ->(dzongkhag) { joins(:donor_info).where(donor_infos: { dzongkhag: dzongkhag }) }
  scope :by_gewog, ->(gewog) { joins(:donor_info).where(donor_infos: { gewog: gewog }) }
end
