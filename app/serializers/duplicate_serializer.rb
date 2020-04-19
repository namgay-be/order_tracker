class DuplicateSerializer < ApplicationSerializer
  key :duplicate
  collection_key :duplicates
  serialize(
    :id,
    :gene_bank_id,
    :weight,
    :packets
  )

  serialize :locations, with: LocationSerializer
end
