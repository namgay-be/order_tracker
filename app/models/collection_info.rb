class CollectionInfo < ApplicationRecord
  belongs_to :seed, inverse_of: :collection_info

  validates :collection_number, presence: true, uniqueness: true
end
