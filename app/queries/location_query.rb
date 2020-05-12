class LocationQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = %w[name].freeze

  def run
    locations
      .then { |locations| search_by_attribute(locations) }
  end

  private

  def search_by_attribute(locations)
    return locations if query.blank?

    locations.search_by_name(attribute_name, query)
  end

  def locations
    Location.all
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :name
  end
end
