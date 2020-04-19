class GeneBankSerializer < ApplicationSerializer
  key :gene_bank
  collection_key :gene_banks
  serialize(
    :id,
    :seed_id,
    :accession_number,
    :packaging_date
  )

  serialize :base_collection, with: BaseCollectionSerializer
  serialize :active_collection, with: ActiveCollectionSerializer
  serialize :characterization, with: CharacterizationSerializer
  serialize :duplicate, with: DuplicateSerializer
end
