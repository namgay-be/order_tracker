class UserSerializer < ApplicationSerializer
  key :user
  collection_key :users
  serialize(
    :id,
    :email,
    :name
  )

  serialize :role, with: RoleSerializer
end
