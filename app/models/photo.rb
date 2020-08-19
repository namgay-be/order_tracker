class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  has_one_attached :image, dependent: :destroy

  validates_presence_of :image
end
