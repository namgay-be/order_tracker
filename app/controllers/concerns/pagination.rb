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
    cache_render serializer, collection, meta: paginate(config), collection: true
  end

  def paginated_collection(resource)
    pagy(
      resource,
      page: params.fetch(:page, 1),
      items: params.fetch(:per_page, 10)
    )
  end
end
