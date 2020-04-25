class Customer < ApplicationRecord
  validates_presence_of :name
  validates :cust_id, uniqueness: true

  def self.search(query)
    where('cust_id ILIKE :query', query: "#{query&.squish}%")
  end
end
