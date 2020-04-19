class Duplicate < ApplicationRecord
  belongs_to :gene_bank, inverse_of: :duplicate

  has_many :locations, as: :locatable, dependent: :destroy
end
