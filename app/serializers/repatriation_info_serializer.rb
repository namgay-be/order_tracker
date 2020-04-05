class RepatriationInfoSerializer < ApplicationSerializer
  key :repatriation_info
  collection_key :repatriation_infos
  serialize(
    :id,
    :repatriation_number,
    :repatriation_date,
    :quantity,
    :initial_germination_rate,
    :resistant,
    :susceptible,
    :condition,
    :donor_accession,
    :donor_name,
    :country,
    :organisation,
    :web_url,
    :email_id,
    :phone,
    :fax,
    :remarks
  )
end
