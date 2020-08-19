class ContactSerializer < ApplicationSerializer
  key :contact
  collection_key :contacts
  serialize(
    :id,
    :name,
    :phone,
    :contact_type,
    :creation_date
  )
end