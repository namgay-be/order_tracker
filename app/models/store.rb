class Store < ApplicationRecord
  include PgSearch::Model

  validates_presence_of :name
  enum category: { grocery: 0, vegetable_store: 1 }

  belongs_to :service_area, inverse_of: :stores, optional: true
  has_one :address, as: :addressable, dependent: :destroy
  has_many :contacts, inverse_of: :store, dependent: :destroy
  has_many :items, inverse_of: :store, dependent: :destroy
  has_many :photos, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for(
    :items,
    :contacts,
    :address,
    :photos,
    allow_destroy: true
  )

  scope :by_dzongkhag, ->(dzongkhag) { joins(:address).where(addresses: { dzongkhag: dzongkhag }) }
  scope :by_gewog, ->(gewog) { joins(:address).where(addresses: { gewog: gewog }) }
  scope :by_village, ->(village) { joins(:address).where(addresses: { village: village }) }
  scope :by_category, ->(category) { where(category: category) }

  pg_search_scope :search_by_name, against: :name, using: { tsearch: { prefix: true } }
end
