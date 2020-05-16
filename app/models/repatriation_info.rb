class RepatriationInfo < ApplicationRecord
  include PgSearch::Model

  belongs_to :foreign_seed, inverse_of: :repatriation_info

  validates :repatriation_number, :quantity, :donor_name, :donor_accession, presence: true
  validates_uniqueness_of :repatriation_number

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
