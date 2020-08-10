module Migrations
  class Distribution < Base
    def run
      ::DistributionInfo.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        distribution = set_distribution(hash)
        if !distribution.save
          puts distribution.errors.messages
        end
      end
      puts 'Success'
    end

    private

    def set_distribution(hash)
      ::DistributionInfo.new(
        seed_id: ::GeneBank.find_by(accession_number: hash[:accession_no])&.seed_id,
        customer_id: customer_id(hash),
        requested_date: hash[:requested_date],
        supplied_date: hash[:supplied_date],
        package_type: package_type(hash),
        quantity: hash[:quantity_supplied],
        purpose: hash[:purpose],
        remarks: hash[:remarks],
        creator_id: hash[:di_user_id],
        finalized: true
      )
    end

    def package_type(hash)
      case hash[:packet_type]
      when 'User Sample'
        'user_sample'
      when 'Characterization'
        'characterization'
      when 'Rest'
        'rest'
      when 'Multiplication and regeneration'
        'regeneration'
      when 'Germination and viability'
        'germination'
      else
        hash[:packet_type]
      end
    end

    def customer_id(hash)
      ::Customer.where('custom_ids && ?', "{#{hash[:customer_id]}}").take.id
    end
  end
end
