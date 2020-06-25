class DonorInfoUpdater < ApplicationForm
  attr_accessor :donor_info

  def update(id)
    @donor_info = DonorInfo.find(id)
    @donor_info.update(params)
  end
end
