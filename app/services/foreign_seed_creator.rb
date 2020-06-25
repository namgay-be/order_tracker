class ForeignSeedCreator < ApplicationForm
  attr_accessor :foreign_seed

  def create
    @foreign_seed = ForeignSeed.new(params)
    @foreign_seed.assign_attributes(creator: current_user)
    @foreign_seed.save
  end
end