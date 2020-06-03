module Pagination
  include CacheCrispies::Controller

  def paginate(resource)
    {
      previous: resource.prev,
      current: resource.page,
      next_page: resource.next,
      last_page: resource.last,
      total: resource.count
    }
  end

  def render_paginated_collection(resource, serializer = nil, root = nil)
    config, collection = paginated_collection(resource)
    cache_render serializer, collection, meta: metadata(config, resource), collection: true
  end

  def paginated_collection(resource)
    pagy(
      resource,
      page: params.fetch(:page, 1),
      items: params.fetch(:per_page, 10)
    )
  end

  def metadata(config, resource)
    resource.take.is_a?(Seed) ? paginate(config).merge(status_counts) : paginate(config)
  end

  def status_counts
    {
      under_process_count: seeds.under_process.size,
      tested_count: seeds.tested.size,
      transferred_count: seeds.transferred.size,
      distributed_count: seeds.distributed.size,
      rejected_count: seeds.rejected.size,
      local_seed_count: seeds.local.size,
      repatriation_seed_count: seeds.by_type('ForeignSeed').size
    }
  end

  def seeds
    case params['duration']
    when 'current_week'
      Seed.where('created_at > :q', q: Date.today.beginning_of_week)
    when 'current_month'
      Seed.where('created_at > :q', q: Date.today.beginning_of_month)
    when 'current_quarter'
      Seed.where('created_at > :q', q: Date.today.beginning_of_quarter)
    when 'current_year'
      Seed.where('created_at > :q', q: Date.today.beginning_of_year)
    else
      Seed.all
    end
  end
end
