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
    :deleted_at
  )

  def image_path
    return nil if model.image&.attachment.nil?

    rails_blob_path(model.image, only_path: true)
  end

  serialize :role, with: RoleSerializer
end
