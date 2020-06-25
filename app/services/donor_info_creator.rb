class DonorInfoCreator < ApplicationForm
  attr_accessor :donor_info

  def create
    @donor_info = DonorInfo.new(params)
    @donor_info.assign_attributes(creator: current_user)
    @donor_info.save
  end
end
