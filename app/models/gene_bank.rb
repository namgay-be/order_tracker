class GeneBank < ApplicationRecord
  belongs_to :seed, inverse_of: :gene_bank

  has_one :base_collection, inverse_of: :gene_bank, dependent: :destroy
  has_one :active_collection, inverse_of: :gene_bank, dependent: :destroy
  has_one :characterization, inverse_of: :gene_bank, dependent: :destroy
  has_one :duplicate, inverse_of: :gene_bank, dependent: :destroy
  has_one :packet_count, inverse_of: :gene_bank, dependent: :destroy

  accepts_nested_attributes_for(
    :base_collection,
    :active_collection,
    :characterization,
    :duplicate,
    allow_destroy: true
  )

  validates_presence_of :packaging_date

  delegate :packets, to: :active_collection, prefix: true
  delegate :packets, to: :characterization, prefix: true
  delegate :packets, to: :duplicate, prefix: true
  delegate(
    :germination_packets,
    :rest_packets,
    :regeneration_packets,
    to: :base_collection
  )
end
