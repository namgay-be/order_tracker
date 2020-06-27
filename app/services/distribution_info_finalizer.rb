class DistributionInfoFinalizer < ApplicationForm
  def run
    distribution_infos = DistributionInfo.where(params['distribution_infos'])
    distribution_infos.each do |dist|
      dist.update_column(:finalized, true)
    end
  end
end
