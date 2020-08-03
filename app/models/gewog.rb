class Gewog < ApplicationRecord
  belongs_to :dzongkhag, inverse_of: :gewogs
  has_many :donor_infos, inverse_of: :gewogs

  delegate :name, to: :dzongkhag, prefix: true
end
