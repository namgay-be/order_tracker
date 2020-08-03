class SeedInfoSerializer < ApplicationSerializer
  key :seed_info
  serialize(
    :id,
    :local_name,
    :local_variety_name
  )
end
