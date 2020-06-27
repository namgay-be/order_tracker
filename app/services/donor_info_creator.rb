class DonorInfoCreator < ApplicationForm
  attr_accessor :donor_info

  def create
    @donor_info = DonorInfo.new(params)
    @donor_info.assign_attributes(creator: current_user)
    @donor_info.save.tap { set_custom_donor_id }
  end

  private

  def set_custom_donor_id
    donor_info.update(custom_donor_id: "DONOR_#{donor_info.id}")
  end
end
