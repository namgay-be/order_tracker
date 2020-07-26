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
      seed.duplicate.update(weight: ((seed.duplicate.weight + old_quantity) - distribution_info.quantity))
    when 'active_collection'
      seed.active_collection.update(weight: ((seed.active_collection.weight + old_quantity) - distribution_info.quantity))
    when 'germination'
      seed.base_collection.update(germination_weight:
                                    ((seed.base_collection.germination_weight + old_quantity) - distribution_info.quantity))
    when 'regeneration'
      seed.base_collection.update(regeneration_weight:
                                    ((seed.base_collection.regeneration_weight + old_quantity) - distribution_info.quantity))
    when 'rest'
      seed.base_collection.update(rest_weight:
                                    ((seed.base_collection.rest_weight + old_quantity) - distribution_info.quantity))
    when 'characterization'
      seed.characterization.update(weight: ((seed.characterization.weight + old_quantity) - distribution_info.quantity))
    end
  end
end