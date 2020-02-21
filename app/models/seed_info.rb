class SeedInfo < ApplicationRecord
  belongs_to :seed, inverse_of: :seed_info

  validates :classification, :crop_name, presence: true

  enum seed_status: { under_process: 0, tested: 5, transferred: 10, rejected: 20 }
end
