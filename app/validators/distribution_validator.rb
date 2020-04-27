class DistributionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    case record.package_type
    when 'duplicate'
      errors(record) if record.seed.duplicate.packets < value
    when 'characterization'
      errors(record) if record.seed.characterization.packets < value
    when 'active_collection'
      errors(record) if record.seed.active_collection.packets < value
    when 'rest'
      errors(record) if record.seed.base_collection.rest_packets < value
    when 'germination'
      errors(record) if record.seed.base_collection.germination_packets < value
    when 'regeneration'
      errors(record) if record.seed.base_collection.regeneration_packets < value
    end
  end

  def errors(record)
    record.errors.add(:quantity, 'entered is more than the available packets for the packet type')
  end
end