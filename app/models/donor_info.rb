class DonorInfo < ApplicationRecord
  include PgSearch::Model

  belongs_to :creator, class_name: 'User', optional: true
  belongs_to :gewog, inverse_of: :donor_infos, optional: true
  has_many :seeds, inverse_of: :donor_info

  validates :donor_name, presence: true

  pg_search_scope :search_by_name, lambda { |name_part, query|
    {
      against: name_part,
      query: query,
      using: {
        tsearch: { prefix: true }
      }
    }
  }

  after_create :save_custom_donor_id

  def save_custom_donor_id
    self.update(custom_donor_id: "DONOR_#{id}")
  end

  delegate :name, to: :gewog, prefix: true, allow_nil: true
  delegate :dzongkhag_name, to: :gewog, allow_nil: true
end
