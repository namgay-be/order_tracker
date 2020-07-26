class DistributionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    case record.package_type
    when 'duplicate'
      errors(record) if (record.seed.duplicate.weight < value || record.seed.duplicate.weight < 20)
    when 'characterization'
      errors(record) if (record.seed.characterization.weight < value || record.seed.characterization.weight < 20)
    when 'active_collection'
      errors(record) if (record.seed.active_collection.weight < value || record.seed.active_collection.weight < 20)
    when 'rest'
      errors(record) if (record.seed.base_collection.rest_weight < value || record.seed.base_collection.rest_weight < 20)
    when 'germination'
      errors(record) if (record.seed.base_collection.germination_weight < value || record.seed.base_collection.germination_weight < 20)
    when 'regeneration'
      errors(record) if (record.seed.base_collection.regeneration_weight < value || record.seed.base_collection.regeneration_weight < 20)
    end
  end

  def errors(record)
    record.errors.add(:quantity, 'entered is more than the available amount for the packet type or the available amount is below 20g')
  end
end