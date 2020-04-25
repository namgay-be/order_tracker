class Seed < ApplicationRecord
  include PgSearch::Model
  include Klass::Seed
  include AASM

  has_one :collection_info, inverse_of: :seed, dependent: :destroy
  has_one :cultivation_info, inverse_of: :seed, dependent: :destroy
  has_one :donor_field_info, inverse_of: :seed, dependent: :destroy
  has_one :donor_info, inverse_of: :seed, dependent: :destroy
  has_one :seed_info, inverse_of: :seed, dependent: :destroy
  has_one :gene_bank, inverse_of: :seed

  has_many :test_details, inverse_of: :seed, dependent: :destroy
  has_many :distribution_infos, inverse_of: :seed, dependent: :nullify

  accepts_nested_attributes_for(
    :seed_info,
    :donor_field_info,
    :donor_info,
    :collection_info,
    :cultivation_info,
    allow_destroy: true
  )

  validates :classification, :crop_name, presence: true

  enum seed_status: {under_process: 0, tested: 5, transferred: 10, rejected: 20}

  scope :local, -> { where(type: nil) }
  scope :by_type, ->(type) { where(type: type) }
  scope :by_crop_name, ->(crop_name) { where(crop_name: crop_name) }
  scope :by_local_name, ->(local_name) { joins(:seed_info).where(seed_infos: {local_name: local_name}) }
  scope :by_local_variety, ->(local_variety) { joins(:seed_info).where(seed_infos: {local_variety_name: local_variety}) }
  scope :by_seed_status, ->(seed_status) { where(seed_status: seed_status) }
  scope :by_classification, ->(classification) { where(classification: classification) }
  scope :by_donor_name, ->(donor) { joins(:donor_info).where(donor_infos: {donor_name: donor}) }
  scope :by_dzongkhag, ->(dzongkhag) { joins(:donor_info).where(donor_infos: {dzongkhag: dzongkhag}) }
  scope :by_gewog, ->(gewog) { joins(:donor_info).where(donor_infos: {gewog: gewog}) }
  scope :by_minimum_altitude, ->(altitude) { joins(:donor_field_info).where('donor_field_infos.altitude > :q', q: altitude) }
  scope :by_maximum_altitude, ->(altitude) { joins(:donor_field_info).where('donor_field_infos.altitude < :q', q: altitude) }
  scope :by_requires_multiplication, ->(flag) { where(requires_multiplication: flag) }

  pg_search_scope :search_by_name, lambda { |name_part, query|
    {
      against: name_part,
      query: query,
      using: {
        tsearch: { prefix: true }
      }
    }
  }

  aasm column: 'seed_status', enum: true, whiny_persistence: false do
    state :under_process, initial: true
    state :tested
    state :transferred
    state :rejected

    event :test do
      transitions from: :under_process, to: :tested
    end

    event :transfer do
      transitions from: :tested, to: :transferred
    end

    event :reject do
      transitions from: :tested, to: :rejected
    end
  end
end
