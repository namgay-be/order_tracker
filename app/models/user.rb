class User < ApplicationRecord
  devise(
    :invitable,
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :invitable,
    :jwt_authenticatable,
    jwt_revocation_strategy: self
  )

  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Klass::User

  belongs_to :role, inverse_of: :users
  has_one_attached :image, dependent: :destroy

  delegate :name, to: :role, prefix: true

  validates :phone, numericality: true, length: { minimum: 6, maximum: 16 }
  
  default_scope { where(deleted_at: nil) }
end
