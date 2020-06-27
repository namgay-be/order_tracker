class SeedsQuery < ApplicationQuery
  SEED_TYPES = %w[ForeignSeed Cryo].freeze

  attr_accessor(
    :query,
    :crop_name,
    :local_name,
    :local_variety,
    :status,
    :donor,
    :dzongkhag,
    :gewog,
    :classification,
    :type,
    :minimum_altitude,
    :maximum_altitude,
    :requires_multiplication
  )

  def run
    seed_type == 'ForeignSeed' ? list_foreign_seeds : list_local_seeds
  end

  private

  def list_local_seeds
    local_seeds
      .then { |seeds| fetch_by_crop_name(seeds) }
      .then { |seeds| fetch_by_local_variety(seeds) }
      .then { |seeds| fetch_by_local_name(seeds) }
      .then { |seeds| fetch_by_status(seeds) }
      .then { |seeds| fetch_by_donor_name(seeds) }
      .then { |seeds| fetch_by_dzongkhag(seeds) }
      .then { |seeds| fetch_by_gewog(seeds) }
      .then { |seeds| fetch_by_classification(seeds) }
      .then { |seeds| fetch_by_minimum_altitude(seeds) }
      .then { |seeds| fetch_by_maximum_altitude(seeds) }
      .then { |seeds| fetch_by_requires_multiplication(seeds) }
      .search(query)
  end

  def list_foreign_seeds
    foreign_seeds
      .then { |seeds| fetch_by_crop_name(seeds) }
      .then { |seeds| fetch_by_status(seeds) }
      .then { |seeds| fetch_by_donor_name(seeds) }
      .then { |seeds| fetch_by_classification(seeds) }
      .then { |seeds| fetch_by_requires_multiplication(seeds) }
      .search(query)
  end

  def local_seeds
    Seed.includes(
      :seed_info,
      :donor_info,
      :cultivation_info,
      :collection_info
    ).by_type(seed_type)
  end

  def foreign_seeds
    ForeignSeed.includes(:repatriation_info)
  end

  def fetch_by_requires_multiplication(seeds)
    return seeds if requires_multiplication.nil?

    seeds.by_requires_multiplication(requires_multiplication)
  end

  def fetch_by_minimum_altitude(seeds)
    return seeds if minimum_altitude.blank?

    seeds.by_minimum_altitude(minimum_altitude)
  end

  def fetch_by_maximum_altitude(seeds)
    return seeds if maximum_altitude.blank?

    seeds.by_maximum_altitude(maximum_altitude)
  end

  def fetch_by_crop_name(seeds)
    return seeds if crop_name.blank?

    seeds.by_crop_name(crop_name)
  end

  def fetch_by_local_name(seeds)
    return seeds if local_name.blank?

    seeds.by_local_name(local_name)
  end

  def fetch_by_local_variety(seeds)
    return seeds if local_variety.blank?

    seeds.by_local_variety(local_variety)
  end

  def fetch_by_status(seeds)
    return seeds if status.blank?

    seeds.by_seed_status(status)
  end

  def fetch_by_donor_name(seeds)
    return seeds if donor.blank?

    seeds.by_donor_name(donor)
  end

  def fetch_by_dzongkhag(seeds)
    return seeds if dzongkhag.blank?

    seeds.by_dzongkhag(dzongkhag)
  end

  def fetch_by_gewog(seeds)
    return seeds if gewog.blank?

    seeds.by_gewog(gewog)
  end

  def fetch_by_classification(seeds)
    return seeds if classification.blank?

    seeds.by_classification(classification)
  end

  def seed_type
    type.presence_in(SEED_TYPES)
  end
end
