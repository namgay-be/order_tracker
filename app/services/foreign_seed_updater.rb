class ForeignSeedUpdater < ApplicationForm
  attr_accessor :foreign_seed

  def update(id)
    @foreign_seed = ForeignSeed.find(id)
    @foreign_seed.update(params)
  end
end
