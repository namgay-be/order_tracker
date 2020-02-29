class DonorFieldInfo < ApplicationRecord
  include PgSearch::Model

  belongs_to :seed, inverse_of: :donor_field_info

  pg_search_scope :search_by_name, lambda { |name_part, query|
    {
      against: name_part,
      query: query
    }
  }
end
