class SeedsListQuery < ApplicationQuery
  attr_accessor :status

  def run
    seeds
      .then { |seeds| fetch_by_seed_status(seeds) }
  end

  private

  def seeds
    Seed.all
  end

  def fetch_by_seed_status(seeds)
    return seeds if status.blank?

    seeds.by_seed_status(status)
  end
end
