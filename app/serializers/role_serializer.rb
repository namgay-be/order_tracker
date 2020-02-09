class RoleSerializer < ApplicationSerializer
  key :role
  serialize(
    :id,
    :name
  )
end
