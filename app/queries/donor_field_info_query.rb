class DonorFieldInfoQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = %w[
    latitude
    longitude
    altitude
    soil_culture
    soil_texture
    topography
   ].freeze

  def run
    donor_field_infos
      .yield_self { |donor_field_infos| search_by_attribute(donor_field_infos) }
  end

  private

  def search_by_attribute(donor_field_infos)
    return donor_field_infos if query.blank?

    donor_field_infos.search_by_name(attribute_name, query)
  end

  def donor_field_infos
    DonorFieldInfo.all
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :soil_culture
  end
end
