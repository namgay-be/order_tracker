class Characterization < ApplicationRecord
  belongs_to :gene_bank, inverse_of: :characterization

  has_one :location, as: :locatable, dependent: :destroy
end
