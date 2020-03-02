class DonorInfo < ApplicationRecord
  include PgSearch::Model

  belongs_to :seed, inverse_of: :donor_info

  validates :house_number, :donor_name, presence: true

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
