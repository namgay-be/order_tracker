class ForeignSeedCreator < ApplicationForm
  attr_accessor :foreign_seed

  def create
    @foreign_seed = ForeignSeed.new(params)
    @foreign_seed.save
  end
end