module Migrations
  class RepatriationInfo < Base
    def run
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        repatriation = ::RepatriationInfo.find_by(id: hash[:source_id])
        next if repatriation.nil?
        
        if !update_repatriation(hash, repatriation)
          puts repatriation.errors.messages
        end
      end
      puts 'Success'
    end

    private

    def update_repatriation(hash, repatriation)
      repatriation.update(
        repatriation_number: hash[:rep_no],
        repatriation_date: hash[:rep_date],
        condition: hash[:seed_condition],
        initial_germination_rate: hash[:int_ger],
        quantity: hash[:quantity],
        remarks: hash[:rep_remarks]
      )
    end
  end
end
