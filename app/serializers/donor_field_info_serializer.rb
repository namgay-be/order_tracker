class DonorFieldInfoSerializer < ApplicationSerializer
  key :donor_field_info
  serialize(
    :id,
    :latitude,
    :longitude,
    :altitude,
    :soil_color,
    :soil_texture,
    :topography,
  )
end
