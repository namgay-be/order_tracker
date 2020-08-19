class UserSerializer < ApplicationSerializer
  key :user
  collection_key :users
  serialize(
    :id,
    :email,
    :name,
    :phone,
    :username,
    :designation,
    :image_path,
    :deleted_at,
    :invitation_accepted
  )

  def invitation_accepted
    model.invitation_accepted?
  end

  serialize :role, with: RoleSerializer
end
