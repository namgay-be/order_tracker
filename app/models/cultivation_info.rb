class CultivationInfo < ApplicationRecord
  belongs_to :seed, inverse_of: :cultivation_info
end
