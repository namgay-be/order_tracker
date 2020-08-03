module Migrations
  class Repatriation < Base
    def run
      ::RepatriationInfo.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        repatriation = set_repatriation(hash)
        if !repatriation.save
          puts repatriation.errors.messages
        end
      end
      puts 'Success'
    end

    private

    def set_repatriation(hash)
      ::RepatriationInfo.new(
        id: hash[:source_id],
        donor_accession: hash[:donor_acc],
        donor_name: hash[:repdonor_name],
        country: hash[:country],
        organisation: hash[:organisation],
        web_url: hash[:web_url],
        email_id: hash[:email],
        phone: hash[:phone],
        fax: hash[:fax],
        foreign_seed_id: seed_id(hash)
      )
    end

    def seed_id(hash)
      ::Seed.find_by(rep_id: hash[:source_id]).id
    end
  end
end
