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
      seed.duplicate.update(packets: (seed.duplicate.packets + distribution_info.quantity))
    when 'active_collection'
      seed.active_collection.update(packets: (seed.active_collection.packets + distribution_info.quantity))
    when 'germination'
      seed.base_collection.update(germination_packets:
                                    (seed.base_collection.germination_packets + distribution_info.quantity))
    when 'regeneration'
      seed.base_collection.update(regeneration_packets:
                                    (seed.base_collection.regeneration_packets + distribution_info.quantity))
    when 'rest'
      seed.base_collection.update(rest_packets:
                                    (seed.base_collection.rest_packets + distribution_info.quantity))
    when 'characterization'
      seed.characterization.update(packets: (seed.characterization.packets + distribution_info.quantity))
    end
  end
end