class SeedCreator < ApplicationForm
  attr_accessor :seed

  def create
    @seed = Seed.new(params)
    seed.save!
  end
end
