class DistributionInfoUpdater < DistributionInfoCreator
  attr_accessor :old_quantity

  def update(id)
    @distribution_info = DistributionInfo.find(id)
    @old_quantity = @distribution_info.quantity

    @distribution_info.update(params).tap do |result|
      result && after_update_actions
    end
  end

  private

  def after_update_actions
    case distribution_info.package_type
    when 'duplicate'
      seed.duplicate.update(packets: ((seed.duplicate.packets + old_quantity) - distribution_info.quantity))
    when 'active_collection'
      seed.active_collection.update(packets: ((seed.active_collection.packets + old_quantity) - distribution_info.quantity))
    when 'germination'
      seed.base_collection.update(germination_packets:
                                    ((seed.base_collection.germination_packets + old_quantity) - distribution_info.quantity))
    when 'regeneration'
      seed.base_collection.update(regeneration_packets:
                                    ((seed.base_collection.regeneration_packets + old_quantity) - distribution_info.quantity))
    when 'rest'
      seed.base_collection.update(rest_packets:
                                    ((seed.base_collection.rest_packets + old_quantity) - distribution_info.quantity))
    when 'characterization'
      seed.characterization.update(packets: ((seed.characterization.packets + old_quantity) - distribution_info.quantity))
    end
  end
end