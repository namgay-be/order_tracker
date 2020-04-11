class SeedAutocompleteQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = %w[
      crop_name
      family
      genus
      species
      sub_texa
      material_type
      classification
      resistant
      susceptible
      seed_status
     ].freeze

  def run
    seeds
      .yield_self { |seeds| search_by_attribute(seeds) }
  end

  private

  def search_by_attribute(seeds)
    return seeds if query.blank?

    seeds.search_by_name(attribute_name, query)
  end

  def seeds
    Seed.all
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :crop_name
  end
end
