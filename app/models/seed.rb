class Seed < ApplicationRecord
  include PgSearch::Model

  has_one :collection_info, inverse_of: :seed, dependent: :destroy
  has_one :cultivation_info, inverse_of: :seed, dependent: :destroy
  has_one :donor_field_info, inverse_of: :seed, dependent: :destroy
  has_one :donor_info, inverse_of: :seed, dependent: :destroy
  has_one :seed_info, inverse_of: :seed, dependent: :destroy

  has_many :test_details, inverse_of: :seed, dependent: :destroy

  include Klass::Seed

  accepts_nested_attributes_for(
    :seed_info,
    :donor_field_info,
    :donor_info,
    :collection_info,
    :cultivation_info,
    allow_destroy: true
  )

  validates :classification, :crop_name, presence: true

  enum seed_status: { under_process: 0, tested: 5, transferred: 10, rejected: 20 }


  scope :by_crop_name, ->(crop_name) { where(crop_name: crop_name) }
  scope :by_local_name, ->(local_name) { joins(:seed_info).where(seed_infos: { local_name: local_name }) }
  scope :by_local_variety, ->(local_variety) { joins(:seed_info).where(seed_infos: { local_variety_name: local_variety }) }
  scope :by_seed_status, ->(seed_status) { where(seed_status: seed_status) }
  scope :by_classification, ->(classification) { where(classification: classification) }
  scope :by_donor_name, ->(donor) { joins(:donor_info).where(donor_infos: { donor_name: donor }) }
  scope :by_dzongkhag, ->(dzongkhag) { joins(:donor_info).where(donor_infos: { dzongkhag: dzongkhag }) }
  scope :by_gewog, ->(gewog) { joins(:donor_info).where(donor_infos: { gewog: gewog }) }

  pg_search_scope :search_by_name, lambda { |name_part, query|
    {
      against: name_part,
      query: query,
      using: {
        tsearch: { prefix: true }
      }
    }
  }
end
