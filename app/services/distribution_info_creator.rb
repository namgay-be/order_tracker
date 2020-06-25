class DistributionInfoCreator < ApplicationForm
  attr_accessor :distribution_info

  def create
    @distribution_info = DistributionInfo.new(params)
    @distribution_info.assign_attributes(creator: current_user)
    @distribution_info.save.tap do |result|
      result && after_save_actions
    end
  end

  protected

  def after_save_actions
    case distribution_info.package_type
    when 'duplicate'
      seed.duplicate.update(packets: (seed.duplicate.packets - distribution_info.quantity))
    when 'active_collection'
      seed.active_collection.update(packets: (seed.active_collection.packets - distribution_info.quantity))
    when 'germination'
      seed.base_collection.update(germination_packets:
                                    (seed.base_collection.germination_packets - distribution_info.quantity))
    when 'regeneration'
      seed.base_collection.update(regeneration_packets:
                                    (seed.base_collection.regeneration_packets - distribution_info.quantity))
    when 'rest'
      seed.base_collection.update(rest_packets:
                                    (seed.base_collection.rest_packets - distribution_info.quantity))
    when 'characterization'
      seed.characterization.update(packets: (seed.characterization.packets - distribution_info.quantity))
    end
  end

  def seed
    @seed ||= distribution_info.seed
  end
end