class Customer < ApplicationRecord
  has_many :distribution_infos, inverse_of: :customer, dependent: :nullify

  validates_presence_of :name
  validates :cust_id, uniqueness: true

  def self.search(query)
    where('cust_id ILIKE :query', query: "#{query&.squish}%")
  end
end
