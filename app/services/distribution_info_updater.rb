class DistributionInfoUpdater < ApplicationForm
  attr_accessor :distribution_info

  def update(id)
    @distribution_info = DistributionInfo.find(id)
    @distribution_info.update(params)
  end
end