class SeedsQuery < ApplicationQuery
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
    :maximum_altitude
  )

  def run
    seeds
      .yield_self { |seeds| fetch_by_type(seeds) }
      .yield_self { |seeds| fetch_by_crop_name(seeds) }
      .yield_self { |seeds| fetch_by_local_name(seeds) }
      .yield_self { |seeds| fetch_by_local_variety(seeds) }
      .yield_self { |seeds| fetch_by_status(seeds) }
      .yield_self { |seeds| fetch_by_donor_name(seeds) }
      .yield_self { |seeds| fetch_by_dzongkhag(seeds) }
      .yield_self { |seeds| fetch_by_gewog(seeds) }
      .yield_self { |seeds| fetch_by_classification(seeds) }
      .yield_self { |seeds| fetch_by_minimum_altitude(seeds) }
      .yield_self { |seeds| fetch_by_maximum_altitude(seeds) }
      .search(query)
  end

  private

  def seeds
    Seed.includes(:seed_info, :donor_info)
  end

  def fetch_by_minimum_altitude(seeds)
    return seeds if minimum_altitude.blank?

    seeds.by_minimum_altitude(minimum_altitude)
  end

  def fetch_by_maximum_altitude(seeds)
    return seeds if maximum_altitude.blank?

    seeds.by_maximum_altitude(maximum_altitude)
  end

  def fetch_by_type(seeds)
    return seeds if type.blank?

    type == 'Seed' ? seeds.local : seeds.by_type(type)
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
end
