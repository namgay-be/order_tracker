class DistributionInfoCreator < ApplicationForm
  attr_accessor :distribution_info

  def create
    @distribution_info = DistributionInfo.new(params)
    @distribution_info.save
  end
end