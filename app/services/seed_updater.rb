class SeedUpdater < ApplicationForm
  attr_accessor :seed

  def update(id)
    @seed = Seed.find(id)
    seed.update(params)
  end
end
