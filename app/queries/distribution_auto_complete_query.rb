class DistributionAutoCompleteQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = ['purpose'].freeze

  def run
    distribution_infos
      .then { |distribution_infos| search_by_attribute(distribution_infos) }
  end

  private

  def distribution_infos
    DistributionInfo.all
  end

  def search_by_attribute(distribution_infos)
    return distribution_infos if query.blank?

    distribution_infos.search_by_name(attribute_name, query)
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :purpose
  end
end
