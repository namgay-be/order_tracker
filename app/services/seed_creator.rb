class SeedCreator < ApplicationForm
  attr_accessor :seed

  def create
    @seed = Seed.new(params)
    @seed.assign_attributes(creator: current_user)
    seed.save
  end
end
