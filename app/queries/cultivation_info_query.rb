class CultivationInfoQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = %w[
    nursery_month
    planting_month
    harvesting_month
    cultivation_practice
    crop_system
    ].freeze

  def run
    cultivation_infos
      .yield_self { |cultivation_infos| search_by_attribute(cultivation_infos) }
  end

  private

  def search_by_attribute(cultivation_infos)
    return cultivation_infos if query.blank?

    cultivation_infos.search_by_name(attribute_name, query)
  end

  def cultivation_infos
    CultivationInfo.all
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :nursery_month
  end
end
