class SeedInfo < ApplicationRecord
  belongs_to :seed, inverse_of: :seed_info

  validates :classification, :crop_name, presence: true
end
