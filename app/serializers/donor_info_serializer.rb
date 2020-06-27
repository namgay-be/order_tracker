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
    :creator_name,
    :creation_date
  )
end
