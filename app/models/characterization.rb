class Characterization < ApplicationRecord
  belongs_to :gene_bank, inverse_of: :characterization

  has_one :location, as: :locatable, dependent: :destroy

  accepts_nested_attributes_for :location, allow_destroy: true

  validates_presence_of :weight, :packets, :location
end
