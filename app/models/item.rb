class Item < ApplicationRecord
  belongs_to :store, inverse_of: :items
  has_many :photos, as: :imageable, dependent: :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :photos, allow_destroy: true
end
