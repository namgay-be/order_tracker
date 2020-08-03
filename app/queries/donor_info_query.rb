class DonorInfoQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = %w[
    donor_name
    house_number
    dungkhag
    village
    latitude
    longitude
    altitude
    soil_color
    soil_texture
    topography
    custom_donor_id
   ].freeze

  def run
    donor_infos
      .yield_self { |donor_infos| search_by_attribute(donor_infos) }
  end

  private

  def search_by_attribute(donor_infos)
    return donor_infos if query.blank?

    donor_infos.search_by_name(attribute_name, query)
  end

  def donor_infos
    DonorInfo.all
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :donor_name
  end
end
