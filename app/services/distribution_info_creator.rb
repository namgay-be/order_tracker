class DistributionInfoCreator < ApplicationForm
  attr_accessor :distribution_info

  def create
    @distribution_info = DistributionInfo.new(params)
    @distribution_info.assign_attributes(creator: current_user)
    distribution_info.transaction do
      @distribution_info.save && move_to_distributed && after_save_actions
    end
  end

  protected

  def move_to_distributed
    distribution_info.seed.distribute! unless distribution_info.seed.distributed?
  end

  def after_save_actions
    case distribution_info.package_type
    when 'duplicate'
      seed.duplicate.update(weight: (seed.duplicate.weight - distribution_info.quantity))
    when 'active_collection'
      seed.active_collection.update(weight: (seed.active_collection.weight - distribution_info.quantity))
    when 'germination'
      seed.base_collection.update(germination_weight:
                                    (seed.base_collection.germination_weight - distribution_info.quantity))
    when 'regeneration'
      seed.base_collection.update(regeneration_weight:
                                    (seed.base_collection.regeneration_weight - distribution_info.quantity))
    when 'rest'
      seed.base_collection.update(rest_weight:
                                    (seed.base_collection.rest_weight - distribution_info.quantity))
    when 'characterization'
      seed.characterization.update(weight: (seed.characterization.weight - distribution_info.quantity))
    end
  end

  def seed
    @seed ||= distribution_info.seed
  end
end