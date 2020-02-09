class User < ApplicationRecord
  devise(
    :invitable,
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :confirmable,
    :invitable,
    :jwt_authenticatable,
    jwt_revocation_strategy: self
  )

  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Klass::User

  belongs_to :role, inverse_of: :users

  delegate :name, to: :role, prefix: true
end
