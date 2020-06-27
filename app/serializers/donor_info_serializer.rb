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
    :latitude,
    :longitude,
    :altitude,
    :soil_color,
    :soil_texture,
    :topography,
    :custom_donor_id,
    :creator_name,
    :creation_date
  )
end
