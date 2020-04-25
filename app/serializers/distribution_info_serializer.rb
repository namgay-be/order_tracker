class DistributionInfoSerializer < ApplicationSerializer
  key :distribution_info
  collection_key :distribution_infos
  serialize(
    :id,
    :seed_id,
    :customer_id,
    :requested_date,
    :supplied_date,
    :package_type,
    :quantity,
    :purpose,
    :remarks
  )
end