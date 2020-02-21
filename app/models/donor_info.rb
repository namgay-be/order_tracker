class DonorInfo < ApplicationRecord
  belongs_to :seed, inverse_of: :donor_info

  validates :house_number, :donor_name, presence: true
end
