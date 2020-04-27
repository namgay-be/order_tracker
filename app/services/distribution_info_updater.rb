class DistributionInfoUpdater < DistributionInfoCreator

  def update(id)
    @distribution_info = DistributionInfo.find(id)
    @distribution_info.update(params).tap do |result|
      result && after_save_actions
    end
  end
end