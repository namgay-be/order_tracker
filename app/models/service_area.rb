class ServiceArea < ApplicationRecord
  include PgSearch::Model

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  validates_presence_of :name

  scope :by_dzongkhag, ->(dzongkhag) { joins(:address).where(addresses: { dzongkhag: dzongkhag }) }
  scope :by_gewog, ->(gewog) { joins(:address).where(addresses: { gewog: gewog }) }
  scope :by_village, ->(village) { joins(:address).where(addresses: { village: village }) }

  pg_search_scope :search_by_name, against: :name, using: { tsearch: { prefix: true } }
end
