class DistributionInfo < ApplicationRecord
  include PgSearch::Model

  belongs_to :customer, inverse_of: :distribution_infos
  belongs_to :seed, inverse_of: :distribution_infos
  belongs_to :creator, class_name: 'User'
  has_many :locations, as: :locatable, dependent: :destroy

  enum package_type: {
    active_collection: 0,
    duplicate: 1,
    germination: 2,
    regeneration: 3,
    rest: 4,
    characterization: 5,
    user_sample: 6
  }

  # validates_presence_of :supplied_date, :requested_date, :package_type, :purpose, :quantity
  validates :quantity, distribution: true
  validates_numericality_of :quantity, greater_than: 0

  accepts_nested_attributes_for :locations, allow_destroy: true

  delegate :name, to: :customer, prefix: true

  default_scope -> { order(created_at: :desc) }

  def self.search(query)
    joins(:customer, seed: :gene_bank).where(
      "CONCAT_WS(
        ' ',
        package_type,
        customers.cust_id,
        customers.name,
        customers.country,
        customers.status,
        customers.organisation,
        gene_banks.accession_number
        ) iLIKE :query",
      query: "%#{query&.squish}%")
  end

  delegate :unique_identifier, to: :seed

  scope :by_package, -> (package) { where(package_type: package) }
  scope :by_customer, -> (id) { joins(:customer).where(customers: { id: id })}
  scope :by_seed, -> (id) { joins(:seed).where(seeds: { id: id })}

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
