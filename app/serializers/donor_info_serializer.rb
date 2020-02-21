class DonorInfoSerializer < ApplicationSerializer
  key :donor_info
  serialize(
    :id,
    :donor_name,
    :house_number,
    :dzongkhag,
    :gewog,
    :dungkhag,
    :village,
  )
end
