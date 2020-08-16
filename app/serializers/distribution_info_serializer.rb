class DistributionInfoSerializer < ApplicationSerializer
  key :distribution_info
  collection_key :distribution_infos
  serialize(
    :id,
    :seed_id,
    :seed_status,
    :customer_id,
    :requested_date,
    :supplied_date,
    :package_type,
    :quantity,
    :purpose,
    :remarks,
    :date_stored,
    :customer_name,
    :unique_identifier,
    :creator_name,
    :creation_date
  )

  serialize :locations, with: LocationSerializer

  def date_stored
    format_date(model.created_at)
  end
end
