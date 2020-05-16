class DistributionInfoQuery < ApplicationQuery
  attr_accessor :query, :package_type

  def run
    distributions
      .then { |distributions| fetch_by_package_type(distributions) }
      .search(query)
  end

  private

  def distributions
    DistributionInfo.all
  end

  def fetch_by_package_type(distributions)
    return distributions if package_type.blank?

    distributions.by_package(package_type)
  end
end