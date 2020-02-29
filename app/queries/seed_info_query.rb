class SeedInfoQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = %w[
      crop_name
      local_name
      local_variety_name
      family
      genus
      species
      sub_texa
      material_type
      classification
      resistant
      susceptible
      sample_status
      seed_status
     ].freeze

  def run
    seed_infos
      .yield_self { |seed_infos| search_by_attribute(seed_infos) }
  end

  private

  def search_by_attribute(seed_infos)
    return seed_infos if query.blank?

    seed_infos.search_by_name(attribute_name, query)
  end

  def seed_infos
    SeedInfo.all
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :crop_name
  end
end
