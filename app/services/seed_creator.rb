class SeedCreator < ApplicationForm
  attr_accessor :seed, :donor_params, :donor

  def create
    @seed = Seed.new(params)
    @seed.assign_attributes(creator: current_user)
    @donor = DonorInfo.new(donor_params) if donor_params.present?
    ActiveRecord::Base.transaction do
      donor.save! if donor.present?
      seed.save!
      seed.update_column(:donor_info_id, donor.id) if donor.present?
      seed
    end
  end
end
