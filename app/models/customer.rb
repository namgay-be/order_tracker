class Customer < ApplicationRecord
  include PgSearch::Model

  belongs_to :creator, class_name: 'User', optional: true
  has_many :distribution_infos, inverse_of: :customer, dependent: :nullify

  validates_presence_of :name
  validates :cust_id, uniqueness: true

  def self.search(query)
    where('CONCAT_WS(cust_id, name) ILIKE :query', query: "#{query&.squish}%")
  end

  pg_search_scope :search_by_name, lambda { |name_part, query|
    {
      against: name_part,
      query: query,
      using: {
        tsearch: { prefix: true }
      }
    }
  }
end
