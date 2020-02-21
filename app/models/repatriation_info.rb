class RepatriationInfo < ApplicationRecord
  belongs_to :foreign_seed, inverse_of: :repatriation_info

  validates :repatriation_number, :quantity, :donor_name, :donor_accession, presence: true
end
