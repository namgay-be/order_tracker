class DistributionInfoDestroyer < DistributionInfoCreator
  def initialize(distribution_info)
    @distribution_info = distribution_info
  end
  
  def run 
    update_packet_count && distribution_info.destroy!  
  end
  
  private 
  
  def update_packet_count
    case distribution_info.package_type
    when 'duplicate'
      seed.duplicate.update(weight: (seed.duplicate.weight + distribution_info.quantity))
    when 'active_collection'
      seed.active_collection.update(weight: (seed.active_collection.weight + distribution_info.quantity))
    when 'germination'
      seed.base_collection.update(germination_weight:
                                    (seed.base_collection.germination_weight + distribution_info.quantity))
    when 'regeneration'
      seed.base_collection.update(regeneration_weight:
                                    (seed.base_collection.regeneration_weight + distribution_info.quantity))
    when 'rest'
      seed.base_collection.update(rest_weight:
                                    (seed.base_collection.rest_weight + distribution_info.quantity))
    when 'characterization'
      seed.characterization.update(weight: (seed.characterization.weight + distribution_info.quantity))
    end
  end
end