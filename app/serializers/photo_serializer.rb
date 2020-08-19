class PhotoSerializer < ApplicationSerializer
  key :photo
  collection_key :photos
  serialize(
    :id,
    :imageable_id,
    :imageable_type,
    :image_path
  )
end