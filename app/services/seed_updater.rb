class SeedUpdater < ApplicationForm
  attr_accessor :seed, :donor, :donor_params

  def update(id)
    @seed = Seed.find(id)
    @donor = seed.donor_info
    ActiveRecord::Base.transaction do
      donor.update!(donor_params) if donor_params.present? && donor.present?
      seed.update!(params)
    end
  end
end
