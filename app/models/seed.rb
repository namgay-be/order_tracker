class Seed < ApplicationRecord
  has_one :collection_info, inverse_of: :seed, dependent: :destroy
  has_one :cultivation_info, inverse_of: :seed, dependent: :destroy
  has_one :donor_field_info, inverse_of: :seed, dependent: :destroy
  has_one :donor_info, inverse_of: :seed, dependent: :destroy
  has_one :seed_info, inverse_of: :seed, dependent: :destroy

  accepts_nested_attributes_for(
    :seed_info,
    :donor_field_info,
    :donor_info,
    :collection_info,
    :cultivation_info,
    allow_destroy: true
  )
end
