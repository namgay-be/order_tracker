class ActiveCollection < ApplicationRecord
  belongs_to :gene_bank, inverse_of: :active_collection

  has_one :location, as: :locatable, dependent: :destroy
end
