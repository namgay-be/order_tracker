class GeneBank < ApplicationRecord
  belongs_to :seed, inverse_of: :gene_bank
  belongs_to :creator, class_name: 'User'

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

  delegate :weight, to: :active_collection, prefix: true
  delegate :weight, to: :characterization, prefix: true
  delegate :weight, to: :duplicate, prefix: true
  delegate(
    :germination_weight,
    :rest_weight,
    :regeneration_weight,
    to: :base_collection
  )

  def transfer_date
    self.created_at.strftime('%d/%m/%Y')
  end
end
