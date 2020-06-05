class DistributionInfoQuery < ApplicationQuery
  attr_accessor :query, :package_type, :customer_id, :seed_id

  def run
    distributions
      .then { |distributions| fetch_by_package_type(distributions) }
      .then { |distributions| fetch_by_customer(distributions) }
      .then { |distributions| fetch_by_seed(distributions) }
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

  def fetch_by_customer(distributions)
    return distributions if customer_id.blank?

    distributions.by_customer(customer_id)
  end

  def fetch_by_seed(distributions)
    return distributions if seed_id.blank?

    distributions.by_seed(seed_id)
  end
end