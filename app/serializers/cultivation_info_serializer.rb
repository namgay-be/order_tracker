class CultivationInfoSerializer < ApplicationSerializer
  key :cultivation_info
  serialize(
    :id,
    :nursery_month,
    :planting_month,
    :harvesting_month,
    :cultivation_practice,
    :crop_system,
    :characteristics,
    :requires_multiplication,
  )
end
