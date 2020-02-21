class CollectionInfoSerializer < ApplicationSerializer
  key :collection_info
  serialize(
    :id,
    :mission_number,
    :collection_number,
    :collection_source,
    :collectors_name,
    :collection_note,
    :collection_date
  )
end
