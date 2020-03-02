class SeedInfo < ApplicationRecord
  include PgSearch::Model

  belongs_to :seed, inverse_of: :seed_info

  validates :classification, :crop_name, presence: true

  enum seed_status: { under_process: 0, tested: 5, transferred: 10, rejected: 20 }

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
