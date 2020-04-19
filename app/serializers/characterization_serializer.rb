class CharacterizationSerializer < ApplicationSerializer
  key :characterization
  collection_key :characterizations
  serialize(
    :id,
    :gene_bank_id,
    :weight,
    :packets
  )

  serialize :location, with: LocationSerializer
end
