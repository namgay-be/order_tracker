class BaseCollection < ApplicationRecord
  belongs_to :gene_bank, inverse_of: :base_collection

  has_many :locations, as: :locatable, dependent: :destroy

  accepts_nested_attributes_for :locations, allow_destroy: true

  validates_presence_of(
    :rest_packets,
    :rest_weight,
    :germination_packets,
    :germination_weight,
    :regeneration_packets,
    :regeneration_weight
  )
end
