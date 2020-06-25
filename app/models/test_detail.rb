class TestDetail < ApplicationRecord
  belongs_to :seed, inverse_of: :test_details
  belongs_to :creator, class_name: 'User'
end
