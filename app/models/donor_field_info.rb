class DonorFieldInfo < ApplicationRecord
  belongs_to :seed, inverse_of: :donor_field_info
end
