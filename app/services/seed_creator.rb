class SeedCreator < ApplicationForm
  attr_accessor :seed, :donor_params, :donor

  def create
    @seed = Seed.new(params)
    @seed.assign_attributes(creator: current_user)
    @donor = DonorInfo.new(donor_params)

    ActiveRecord::Base.transaction do
      donor.save!
      seed.save!
      seed.update_column(:donor_info_id, donor.id)
    end
  end
end
