class CollectionInfo < ApplicationRecord
  include PgSearch::Model

  belongs_to :seed, inverse_of: :collection_info

  validates :collection_number, presence: true, uniqueness: true

  pg_search_scope :search_by_name, lambda { |name_part, query|
    {
      against: name_part,
      query: query
    }
  }
end
