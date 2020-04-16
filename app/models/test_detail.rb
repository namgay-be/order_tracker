class TestDetail < ApplicationRecord
  belongs_to :seed, inverse_of: :test_details
end
