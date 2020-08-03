class Dzongkhag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :gewogs, inverse_of: :dzongkhag, dependent: :destroy
end
