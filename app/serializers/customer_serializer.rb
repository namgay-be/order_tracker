class CustomerSerializer < ApplicationSerializer
  key :customer
  collection_key :customers
  serialize(
    :id,
    :cust_id,
    :name,
    :designation,
    :organisation,
    :status,
    :address
  )
end