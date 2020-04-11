class SeedInfo < ApplicationRecord
  include PgSearch::Model

  belongs_to :seed, inverse_of: :seed_info

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
